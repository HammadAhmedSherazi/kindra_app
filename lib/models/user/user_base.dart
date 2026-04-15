import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/enums.dart';

/// Common user fields stored at `users/{uid}`.
class UserBase {
  const UserBase({
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

  // Optional common profile fields (can be moved to role profiles if needed).
  final String? address;
  final DateTime? dateOfBirth;

  UserBase copyWith({
    String? email,
    String? displayName,
    String? phone,
    String? phoneDialCode,
    LoginUserRole? role,
    String? photoUrl,
    String? address,
    DateTime? dateOfBirth,
  }) {
    return UserBase(
      uid: uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      phoneDialCode: phoneDialCode ?? this.phoneDialCode,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  factory UserBase.fromFirestore({
    required String uid,
    required Map<String, dynamic> data,
  }) {
    final dob = data['dateOfBirth'];
    DateTime? dobDateTime;
    if (dob is Timestamp) dobDateTime = dob.toDate();
    if (dob is DateTime) dobDateTime = dob;

    return UserBase(
      uid: uid,
      email: (data['email'] as String?) ?? '',
      displayName: (data['displayName'] as String?) ?? '',
      phone: (data['phone'] as String?) ?? '',
      phoneDialCode: (data['phoneDialCode'] as String?) ?? '',
      role: loginUserRoleFromName(data['role'] as String?),
      photoUrl: (data['photoUrl'] as String?) ?? '',
      address: data['address'] as String?,
      dateOfBirth: dobDateTime,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'email': email,
        'displayName': displayName,
        'phone': phone,
        'phoneDialCode': phoneDialCode,
        'role': role?.name,
        'photoUrl': photoUrl,
        'address': address,
        'dateOfBirth': dateOfBirth == null ? null : Timestamp.fromDate(dateOfBirth!),
      }..removeWhere((k, v) => v == null);
}

