import '../../export_all.dart';

/// Driver Profile tab: overlapping avatar, details card, Bank Account / Settings, Go Offline, Logout.
class DriverProfileTab extends StatefulWidget {
  const DriverProfileTab({super.key});

  @override
  State<DriverProfileTab> createState() => _DriverProfileTabState();
}

class _DriverProfileTabState extends State<DriverProfileTab> {
  bool _isOnline = true;

  static const String _name = 'Thomas Charlie';
  static const String _phone = '+91 98765 43210';
  static const String _vehicle = 'MH04 AB 1234';
  static const double _rating = 4.6;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    // Same idea as [DriverHomeTab]: body starts below header overlap region.
    // Top inset clears header + overlapping avatar + [displayName] (see DriverProfileOverlappingAvatar).
    final bodyTop = kDriverProfileHeaderHeight +
        kDriverProfileAvatarSize / 2 +
        10 +
        28 +
        12;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: '',
            sectionTitle: 'Driver Profile',
            height: kDriverProfileHeaderHeight,
            showZoneLabel: false,
            onLogout: () {},
            showNotificationIcon: true,
            showSideActionLabel: false,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: bodyTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildInfoCard(context),
                        16.ph,
                        _buildMenuTile(
                          context,
                          label: 'Bank Account',
                          onTap: () =>
                              AppRouter.push(const DriverBankAccountView()),
                        ),
                        12.ph,
                        _buildMenuTile(
                          context,
                          label: 'Settings',
                          onTap: () =>
                              AppRouter.push(const DriverSettingsView()),
                        ),
                        28.ph,
                        CustomButtonWidget(
                          label: _isOnline ? 'Go Offline' : 'Go Online',
                          onPressed: () =>
                              setState(() => _isOnline = !_isOnline),
                          height: 56,
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                        12.ph,
                        CustomButtonWidget(
                          label: 'Logout',
                          onPressed: () => showLogoutDialog(context),
                          variant: CustomButtonVariant.secondary,
                          backgroundColor: const Color(0xff2F2F2F),
                          textColor: Colors.white,
                          height: 56,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          DriverProfileOverlappingAvatar(
            displayName: _name,
            onBadgeTap: () => AppRouter.push(const DriverEditProfileView()),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _infoRow(
            context,
            Image.asset(Assets.telephoneIcon, width: 22, height: 22),
            _phone,
          ),
          Divider(height: 22, color: Colors.grey.shade200),
          _infoRow(
            context,
            Icon(Icons.local_shipping_outlined,
                size: 22, color: Colors.black87),
            _vehicle,
          ),
          Divider(height: 22, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined,
                    size: 22, color: Colors.black87),
                14.pw,
                Text(
                  'Rating',
                  style: context.robotoFlexRegular(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                DriverRatingStarsRow(rating: _rating),
                8.pw,
                Text(
                  _rating.toStringAsFixed(1),
                  style: context.robotoFlexSemiBold(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, Widget leading, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          leading,
          14.pw,
          Expanded(
            child: Text(
              text,
              style: context.robotoFlexRegular(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: context.robotoFlexSemiBold(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade500),
            ],
          ),
        ),
      ),
    );
  }
}
