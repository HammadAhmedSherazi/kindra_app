import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user/user_base.dart';
import '../services/firebase_auth_service.dart';

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserBaseProvider = StreamProvider.autoDispose<UserBase?>((ref) {
  // IMPORTANT: listen to auth changes so UI updates after login/logout.
  return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
    if (user == null) return Stream.value(null);

    return FirebaseFirestore.instance
        .collection(FirebaseAuthService.usersCollection)
        .doc(user.uid)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      final data = doc.data();
      if (data == null) return null;
      return UserBase.fromFirestore(uid: user.uid, data: data);
    });
  });
});

