import '../../utils/enums.dart';

/// Base for role-specific profile data stored at:
/// `users/{uid}/profiles/{roleName}`
abstract class RoleProfile {
  const RoleProfile({required this.role});
  final LoginUserRole role;

  Map<String, dynamic> toFirestore();
}

class HouseholderProfile extends RoleProfile {
  const HouseholderProfile({
    super.role = LoginUserRole.householder,
    this.householdSize,
  });

  final int? householdSize;

  HouseholderProfile copyWith({int? householdSize}) =>
      HouseholderProfile(householdSize: householdSize ?? this.householdSize);

  factory HouseholderProfile.fromFirestore(Map<String, dynamic> data) =>
      HouseholderProfile(householdSize: data['householdSize'] as int?);

  @override
  Map<String, dynamic> toFirestore() => {
        'householdSize': householdSize,
      }..removeWhere((k, v) => v == null);
}

class CommunityProfile extends RoleProfile {
  const CommunityProfile({
    super.role = LoginUserRole.communities,
    this.communityName,
  });
  final String? communityName;

  CommunityProfile copyWith({String? communityName}) => CommunityProfile(
        communityName: communityName ?? this.communityName,
      );

  factory CommunityProfile.fromFirestore(Map<String, dynamic> data) =>
      CommunityProfile(communityName: data['communityName'] as String?);

  @override
  Map<String, dynamic> toFirestore() => {
        'communityName': communityName,
      }..removeWhere((k, v) => v == null);
}

class BusinessProfile extends RoleProfile {
  const BusinessProfile({
    super.role = LoginUserRole.businesses,
    this.businessName,
    this.businessCategory,
  });

  final String? businessName;
  final String? businessCategory;

  BusinessProfile copyWith({String? businessName, String? businessCategory}) =>
      BusinessProfile(
        businessName: businessName ?? this.businessName,
        businessCategory: businessCategory ?? this.businessCategory,
      );

  factory BusinessProfile.fromFirestore(Map<String, dynamic> data) =>
      BusinessProfile(
        businessName: data['businessName'] as String?,
        businessCategory: data['businessCategory'] as String?,
      );

  @override
  Map<String, dynamic> toFirestore() => {
        'businessName': businessName,
        'businessCategory': businessCategory,
      }..removeWhere((k, v) => v == null);
}

class CoastalGroupProfile extends RoleProfile {
  const CoastalGroupProfile({
    super.role = LoginUserRole.coastalGroups,
    this.groupName,
  });
  final String? groupName;

  CoastalGroupProfile copyWith({String? groupName}) =>
      CoastalGroupProfile(groupName: groupName ?? this.groupName);

  factory CoastalGroupProfile.fromFirestore(Map<String, dynamic> data) =>
      CoastalGroupProfile(groupName: data['groupName'] as String?);

  @override
  Map<String, dynamic> toFirestore() => {
        'groupName': groupName,
      }..removeWhere((k, v) => v == null);
}

class DriverProfile extends RoleProfile {
  const DriverProfile({
    super.role = LoginUserRole.drivers,
    this.vehicleNumber,
    this.licenseNumber,
  });

  final String? vehicleNumber;
  final String? licenseNumber;

  DriverProfile copyWith({String? vehicleNumber, String? licenseNumber}) =>
      DriverProfile(
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        licenseNumber: licenseNumber ?? this.licenseNumber,
      );

  factory DriverProfile.fromFirestore(Map<String, dynamic> data) => DriverProfile(
        vehicleNumber: data['vehicleNumber'] as String?,
        licenseNumber: data['licenseNumber'] as String?,
      );

  @override
  Map<String, dynamic> toFirestore() => {
        'vehicleNumber': vehicleNumber,
        'licenseNumber': licenseNumber,
      }..removeWhere((k, v) => v == null);
}

RoleProfile roleProfileFromFirestore(LoginUserRole role, Map<String, dynamic> data) {
  switch (role) {
    case LoginUserRole.householder:
      return HouseholderProfile.fromFirestore(data);
    case LoginUserRole.communities:
      return CommunityProfile.fromFirestore(data);
    case LoginUserRole.businesses:
      return BusinessProfile.fromFirestore(data);
    case LoginUserRole.coastalGroups:
      return CoastalGroupProfile.fromFirestore(data);
    case LoginUserRole.drivers:
      return DriverProfile.fromFirestore(data);
  }
}

