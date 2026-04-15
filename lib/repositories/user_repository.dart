import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user/role_profiles.dart';
import '../models/user/user_base.dart';
import '../services/firebase_auth_service.dart';
import '../utils/enums.dart';

class UserRepository {
  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _firestore.collection(FirebaseAuthService.usersCollection).doc(uid);

  DocumentReference<Map<String, dynamic>> _roleDoc(String uid, LoginUserRole role) =>
      _userDoc(uid).collection('profiles').doc(role.name);

  Stream<UserBase?> watchCurrentUserBase() {
    return _auth.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value(null);
      return _userDoc(user.uid).snapshots().map((doc) {
        final data = doc.data();
        if (!doc.exists || data == null) return null;
        return UserBase.fromFirestore(uid: user.uid, data: data);
      });
    });
  }

  Stream<RoleProfile?> watchCurrentUserRoleProfile(LoginUserRole role) {
    return _auth.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value(null);
      return _roleDoc(user.uid, role).snapshots().map((doc) {
        final data = doc.data();
        if (!doc.exists || data == null) return null;
        return roleProfileFromFirestore(role, data);
      });
    });
  }

  Future<void> ensureRoleProfileExists(String uid, LoginUserRole role) async {
    final doc = await _roleDoc(uid, role).get();
    if (doc.exists) return;
    await _roleDoc(uid, role).set({'createdAt': FieldValue.serverTimestamp()});
  }

  Future<void> updateCurrentUserBase(UserBase updated) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('No user signed in');
    await _userDoc(uid).set(updated.toFirestore(), SetOptions(merge: true));
  }

  Future<void> updateCurrentUserRoleProfile(RoleProfile profile) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('No user signed in');
    await _roleDoc(uid, profile.role)
        .set(profile.toFirestore(), SetOptions(merge: true));
  }
}

