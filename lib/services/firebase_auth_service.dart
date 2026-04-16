import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:convert';

import '../utils/enums.dart';
import 'fcm_service.dart';
import 'secure_storage.dart';
import '../models/user/user_base.dart';

Map<String, dynamic> _roleProfileFieldsForSignUp({
  required LoginUserRole role,
  required String displayName,
  String? businessCategory,
  String? groupName,
  String? vehicleRegistration,
}) {
  switch (role) {
    case LoginUserRole.businesses:
      return {
        'businessName': displayName,
        if (businessCategory != null && businessCategory.trim().isNotEmpty)
          'businessCategory': businessCategory.trim(),
      };
    case LoginUserRole.coastalGroups:
      return {
        if (groupName != null && groupName.trim().isNotEmpty)
          'groupName': groupName.trim(),
      };
    case LoginUserRole.drivers:
      return {
        if (vehicleRegistration != null && vehicleRegistration.trim().isNotEmpty)
          'vehicleNumber': vehicleRegistration.trim(),
      };
    case LoginUserRole.householder:
    case LoginUserRole.communities:
      return {};
  }
}

/// Firebase Auth + Firestore profile for Kindra.
///
/// Email verification: Firebase sends an **email with a link** (not a numeric OTP).
/// Password reset: Firebase also sends a **link** to choose a new password.
class FirebaseAuthService {
  FirebaseAuthService._();

  static final FirebaseAuthService instance = FirebaseAuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static const String usersCollection = 'users';
  static const String fcmTokenField = 'fcmToken';

  User? get currentUser => _auth.currentUser;

  String? get currentUserEmail => _auth.currentUser?.email;

  String? get currentUserDisplayName => _auth.currentUser?.displayName;

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String displayName,
    required String phone,
    required String phoneDialCode,
    required LoginUserRole role,
    String? profileImagePath,
    /// Businesses: from category dropdown.
    String? businessCategory,
    /// Coastal groups: group display name.
    String? groupName,
    /// Drivers: vehicle registration number (stored as `vehicleNumber` in profile).
    String? vehicleRegistration,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    final cred = await _auth.createUserWithEmailAndPassword(
      email: normalizedEmail,
      password: password,
    );
    final user = cred.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'null-user',
        message: 'Account was not created.',
      );
    }

    try {
      // Extra safety: ensure one account per email in Firestore.
      // Firebase Auth should already enforce this, but this protects against
      // misconfiguration or multiple auth providers writing to the same `users` collection.
      await _firestore.runTransaction((tx) async {
        final emailDoc = _firestore.collection('user_emails').doc(normalizedEmail);
        final snap = await tx.get(emailDoc);
        if (snap.exists) {
          throw FirebaseAuthException(
            code: 'email-already-in-use',
            message: 'This email is already registered.',
          );
        }
        tx.set(emailDoc, {
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      });

      await user.updateDisplayName(displayName.trim());
      await user.reload();

      var photoUrl = '';
      if (profileImagePath != null && profileImagePath.trim().isNotEmpty) {
        final ref =
            _storage.ref().child('users/${user.uid}/profile.jpg');
        final task = await ref.putFile(File(profileImagePath));
        photoUrl = await task.ref.getDownloadURL();
      }

      await _firestore.collection(usersCollection).doc(user.uid).set({
        'email': normalizedEmail,
        'displayName': displayName.trim(),
        'phone': phone.trim(),
        'phoneDialCode': phoneDialCode,
        'role': role.name,
        'photoUrl': photoUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _syncFcmTokenForUid(user.uid);
      final profilePayload = <String, dynamic>{
        'createdAt': FieldValue.serverTimestamp(),
        ..._roleProfileFieldsForSignUp(
          role: role,
          displayName: displayName.trim(),
          businessCategory: businessCategory,
          groupName: groupName,
          vehicleRegistration: vehicleRegistration,
        ),
      };
      await _firestore
          .collection(usersCollection)
          .doc(user.uid)
          .collection('profiles')
          .doc(role.name)
          .set(profilePayload, SetOptions(merge: true));
      await user.sendEmailVerification();
    } catch (e) {
      await user.delete();
      rethrow;
    }

    return cred;
  }

  /// Recovery path: if Auth account exists but Firestore user doc was deleted,
  /// recreate/merge the app user profile in `users/{uid}` and role profile doc.
  Future<void> recreateFirestoreProfileForCurrentUser({
    required String displayName,
    required String phone,
    required String phoneDialCode,
    required LoginUserRole role,
    String? profileImagePath,
    String? businessCategory,
    String? groupName,
    String? vehicleRegistration,
  }) async {
    final u = _auth.currentUser;
    if (u == null) throw StateError('No user signed in');

    final normalizedEmail = (u.email ?? '').trim().toLowerCase();
    final safeName = displayName.trim();

    if (safeName.isNotEmpty && safeName != u.displayName) {
      await u.updateDisplayName(safeName);
      await u.reload();
    }

    var photoUrl = '';
    if (profileImagePath != null && profileImagePath.trim().isNotEmpty) {
      final ref = _storage.ref().child('users/${u.uid}/profile.jpg');
      final task = await ref.putFile(File(profileImagePath));
      photoUrl = await task.ref.getDownloadURL();
    }

    await _firestore.collection(usersCollection).doc(u.uid).set(
      {
        'email': normalizedEmail,
        'displayName': safeName,
        'phone': phone.trim(),
        'phoneDialCode': phoneDialCode,
        'role': role.name,
        if (photoUrl.isNotEmpty) 'photoUrl': photoUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    await _firestore
        .collection(usersCollection)
        .doc(u.uid)
        .collection('profiles')
        .doc(role.name)
        .set(
          {
            'updatedAt': FieldValue.serverTimestamp(),
            ..._roleProfileFieldsForSignUp(
              role: role,
              displayName: safeName,
              businessCategory: businessCategory,
              groupName: groupName,
              vehicleRegistration: vehicleRegistration,
            ),
          },
          SetOptions(merge: true),
        );

    if (!isEmailVerified) {
      await u.sendEmailVerification();
    }
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  Future<void> sendVerificationEmail() async {
    final u = _auth.currentUser;
    if (u == null) {
      throw StateError('No user signed in');
    }
    await u.sendEmailVerification();
  }

  Future<void> reloadCurrentUser() async {
    await _auth.currentUser?.reload();
  }

  bool get isEmailVerified =>
      _auth.currentUser?.emailVerified ?? false;

  Future<LoginUserRole?> fetchRoleForCurrentUser() async {
    final u = _auth.currentUser;
    if (u == null) return null;
    final doc =
        await _firestore.collection(usersCollection).doc(u.uid).get();
    if (!doc.exists) return null;
    return loginUserRoleFromName(doc.data()?['role'] as String?);
  }

  Future<UserBase?> fetchCurrentUserProfile() async {
    final u = _auth.currentUser;
    if (u == null) return null;
    final doc = await _firestore.collection(usersCollection).doc(u.uid).get();
    if (!doc.exists) return null;
    final data = doc.data();
    if (data == null) return null;
    return UserBase.fromFirestore(uid: u.uid, data: data);
  }

  Future<void> recordSuccessfulLogin(LoginUserRole selectedRole) async {
    final u = _auth.currentUser;
    if (u == null) return;
    await _syncFcmTokenForUid(u.uid);
    _startFcmRefreshListener(u.uid);
    await _firestore.collection(usersCollection).doc(u.uid).set(
      {
        'lastLoginAt': FieldValue.serverTimestamp(),
        'lastLoginRole': selectedRole.name,
      },
      SetOptions(merge: true),
    );

    // Cache minimal info for faster startup routing.
    await SecureStorageManager.sharedInstance.writeUserData(
      jsonEncode(<String, dynamic>{
        'uid': u.uid,
        'role': selectedRole.name,
      }),
    );
  }

  Future<void> updateCurrentUserProfile({
    required String displayName,
    required String phone,
    required String phoneDialCode,
    String? address,
    DateTime? dateOfBirth,
    String? profileImagePath,
  }) async {
    final u = _auth.currentUser;
    if (u == null) {
      throw StateError('No user signed in');
    }

    final safeName = displayName.trim();
    if (safeName.isNotEmpty && safeName != u.displayName) {
      await u.updateDisplayName(safeName);
      await u.reload();
    }

    final data = <String, dynamic>{
      'displayName': safeName,
      'phone': phone.trim(),
      'phoneDialCode': phoneDialCode,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (address != null) data['address'] = address.trim();
    if (dateOfBirth != null) {
      data['dateOfBirth'] = Timestamp.fromDate(dateOfBirth);
    }

    if (profileImagePath != null && profileImagePath.trim().isNotEmpty) {
      final ref = _storage.ref().child('users/${u.uid}/profile.jpg');
      final task = await ref.putFile(File(profileImagePath));
      final photoUrl = await task.ref.getDownloadURL();
      data['photoUrl'] = photoUrl;
      await u.updatePhotoURL(photoUrl);
      await u.reload();
    }

    await _firestore.collection(usersCollection).doc(u.uid).set(
          data,
          SetOptions(merge: true),
        );
  }

  Future<void> signOut() async {
    await FcmService.instance.stopTokenListener();
    await _auth.signOut();
  }

  Future<void> _syncFcmTokenForUid(String uid) async {
    try {
      await FcmService.instance.ensurePermission();
      final token = await FcmService.instance.getToken();
      if (token == null || token.trim().isEmpty) return;
      await _firestore.collection(usersCollection).doc(uid).set(
        {
          fcmTokenField: token,
          'fcmUpdatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (_) {
      // Don't block auth flows on FCM token issues.
    }
  }

  void _startFcmRefreshListener(String uid) {
    FcmService.instance.startTokenListener((token) async {
      if (token.trim().isEmpty) return;
      try {
        await _firestore.collection(usersCollection).doc(uid).set(
          {
            fcmTokenField: token,
            'fcmUpdatedAt': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      } catch (_) {}
    });
  }

  Future<void> clearLocalAuthCache() async {
    await SecureStorageManager.sharedInstance.clearAll();
  }

  Future<LoginUserRole?> readCachedLoginRole() async {
    try {
      final raw = await SecureStorageManager.sharedInstance.getUserData();
      if (raw == null || raw.trim().isEmpty) return null;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return loginUserRoleFromName(map['role'] as String?);
    } catch (_) {
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) => _auth
      .sendPasswordResetEmail(email: email.trim().toLowerCase());

  /// Completes password reset using the `oobCode` from the Firebase email link.
  Future<void> confirmPasswordReset({
    required String oobCode,
    required String newPassword,
  }) {
    return _auth.confirmPasswordReset(
      code: oobCode,
      newPassword: newPassword,
    );
  }

  static String messageForAuthException(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'weak-password':
          return 'Password is too weak.';
        case 'email-already-in-use':
          return 'This email is already registered.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'user-not-found':
          return 'User not exist';
        case 'wrong-password':
          return 'Invalid credentials';
        case 'invalid-credential':
          return 'Invalid credentials';
        case 'too-many-requests':
          return 'Too many attempts. Try again later.';
        case 'expired-action-code':
          return 'This reset link has expired. Request a new one.';
        case 'invalid-action-code':
          return 'This reset link is invalid or was already used.';
        default:
          return error.message?.isNotEmpty == true
              ? error.message!
              : 'Something went wrong. Please try again.';
      }
    }
    return error.toString();
  }
}
