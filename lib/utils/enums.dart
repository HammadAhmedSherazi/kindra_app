enum UserType {
  customer,
  staff,
  manager,
}

/// User role shown on login for multi-user app (Householder, Communities, etc.).
enum LoginUserRole {
  householder,
  communities,
  businesses,
  coastalGroups,
  drivers,
  globalAdmin,
}

extension LoginUserRoleExtension on LoginUserRole {
  String get displayName {
    switch (this) {
      case LoginUserRole.householder:
        return 'Householder';
      case LoginUserRole.communities:
        return 'Communities';
      case LoginUserRole.businesses:
        return 'Businesses';
      case LoginUserRole.coastalGroups:
        return 'Coastal groups';
      case LoginUserRole.drivers:
        return 'Drivers';
      case LoginUserRole.globalAdmin:
        return 'Global Admin';
    }
  }
}
