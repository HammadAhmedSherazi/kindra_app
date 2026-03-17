import '../../export_all.dart';

/// Driver Profile tab. Follows same header pattern as other driver tabs.
class DriverProfileTab extends StatelessWidget {
  const DriverProfileTab({super.key});

  static const String _driverName = 'Driver Name';
  static const String _email = 'driver@kindra.com';
  static const String _phone = '(555) 123 4567';

  @override
  Widget build(BuildContext context) {
    final contentTop = context.screenHeight * 0.22;
    final horizontalPadding = context.screenWidth * 0.05;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Driver',
            sectionTitle: 'Profile',
            showZoneLabel: false,
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProfileCard(context),
                  16.ph,
                  CustomButtonWidget(
                    label: 'Edit Profile',
                    onPressed: () {},
                    variant: CustomButtonVariant.primary,
                    height: 52,
                  ),
                  12.ph,
                  CustomButtonWidget(
                    label: 'Log Out',
                    onPressed: () => showLogoutDialog(context),
                    variant: CustomButtonVariant.secondary,
                    backgroundColor: Colors.grey.shade400,
                    height: 52,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: const AssetImage(Assets.userAvatar),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _driverName,
                  style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                ),
                6.ph,
                Text(
                  _email,
                  style: context.robotoFlexRegular(fontSize: 14, color: Colors.black87),
                ),
                4.ph,
                Text(
                  _phone,
                  style: context.robotoFlexRegular(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
