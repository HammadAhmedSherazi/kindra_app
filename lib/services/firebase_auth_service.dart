import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:convert';

import '../utils/enums.dart';
import 'secure_storage.dart';

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
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
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
        'email': email.trim(),
        'displayName': displayName.trim(),
        'phone': phone.trim(),
        'phoneDialCode': phoneDialCode,
        'role': role.name,
        'photoUrl': photoUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await user.sendEmailVerification();
    } catch (e) {
      await user.delete();
      rethrow;
    }

    return cred;
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
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

  Future<void> recordSuccessfulLogin(LoginUserRole selectedRole) async {
    final u = _auth.currentUser;
    if (u == null) return;
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

    await _firestore.collection(usersCollection).doc(u.uid).set(
          data,
          SetOptions(merge: true),
        );
  }

  Future<void> signOut() => _auth.signOut();

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

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email.trim());

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
        default:
          return error.message?.isNotEmpty == true
              ? error.message!
              : 'Something went wrong. Please try again.';
      }
    }
    return error.toString();
  }
}
