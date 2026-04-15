import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/enums.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.phone,
    required this.phoneDialCode,
    required this.role,
    required this.photoUrl,
    this.address,
    this.dateOfBirth,
  });

  final String uid;
  final String email;
  final String displayName;
  final String phone;
  final String phoneDialCode;
  final LoginUserRole? role;
  final String photoUrl;
  final String? address;
  final DateTime? dateOfBirth;

  factory UserProfile.fromFirestore({
    required String uid,
    required Map<String, dynamic> data,
  }) {
    final roleName = data['role'] as String?;
    final dob = data['dateOfBirth'];
    DateTime? dobDateTime;
    if (dob is Timestamp) {
      dobDateTime = dob.toDate();
    } else if (dob is DateTime) {
      dobDateTime = dob;
    }
    return UserProfile(
      uid: uid,
      email: (data['email'] as String?) ?? '',
      displayName: (data['displayName'] as String?) ?? '',
      phone: (data['phone'] as String?) ?? '',
      phoneDialCode: (data['phoneDialCode'] as String?) ?? '',
      role: loginUserRoleFromName(roleName),
      photoUrl: (data['photoUrl'] as String?) ?? '',
      address: (data['address'] as String?),
      dateOfBirth: dobDateTime,
    );
  }
}

