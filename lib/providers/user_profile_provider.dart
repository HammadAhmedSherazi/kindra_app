import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile.dart';
import '../services/firebase_auth_service.dart';

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserProfileProvider = StreamProvider<UserProfile?>((ref) {
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
      return UserProfile.fromFirestore(uid: user.uid, data: data);
    });
  });
});

