import '../views/business_dashboard/business_dashboard_view.dart';
import '../views/coastal_group/coastal_group_navigation_view.dart';
import '../views/community_dashboard/community_dashboard_view.dart';
import '../views/driver_dashboard/driver_dashboard_view.dart';
import '../views/navigation/navigation_view.dart';
import 'constant.dart';
import 'enums.dart';
import 'router.dart';

UserType userTypeForLoginRole(LoginUserRole role) {
  switch (role) {
    case LoginUserRole.drivers:
      return UserType.staff;
    case LoginUserRole.householder:
    case LoginUserRole.communities:
    case LoginUserRole.businesses:
    case LoginUserRole.coastalGroups:
      return UserType.customer;
  }
}

void navigateToDashboardForRole(LoginUserRole role) {
  AppConstant.userType = userTypeForLoginRole(role);
  switch (role) {
    case LoginUserRole.communities:
      AppRouter.pushAndRemoveUntil(const CommunityDashboardView());
    case LoginUserRole.businesses:
      AppRouter.pushAndRemoveUntil(const BusinessDashboardView());
    case LoginUserRole.coastalGroups:
      AppRouter.pushAndRemoveUntil(const CoastalGroupNavigationView());
    case LoginUserRole.drivers:
      AppRouter.pushAndRemoveUntil(const DriverDashboardView());
    case LoginUserRole.householder:
      AppRouter.pushAndRemoveUntil(const NavigationView());
  }
}
