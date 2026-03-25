import '../../export_all.dart';
import 'driver_pickup_flow/driver_pickup_flow_shared_widgets.dart';

/// Driver settings: notifications, language, dark mode, logout row.
class DriverSettingsView extends StatefulWidget {
  const DriverSettingsView({super.key});

  @override
  State<DriverSettingsView> createState() => _DriverSettingsViewState();
}

class _DriverSettingsViewState extends State<DriverSettingsView> {
  bool _notificationsOn = true;
  bool _darkModeOn = false;

  static const double _settingsCardBlockHeight = 258;
  static const double _belowSettingsCardGap = 14;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final settingsCardTop = communityDashboardStackContentTop(
      context,
      hasSubtitle: false,
    );
    final scrollBodyTop =
        settingsCardTop + _settingsCardBlockHeight + _belowSettingsCardGap;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 4),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CommunityDashboardHeader(
              subtitle: '',
              sectionTitle: 'Setting',
              height: kDriverProfileHeaderHeight,
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              showSideActionLabel: false,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                scrollBodyTop,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButtonWidget(
                    label: 'Save Changes',
                    onPressed: () => AppRouter.back(),
                    height: 56,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: settingsCardTop,
            left: horizontalPadding,
            right: horizontalPadding,
            child: _settingsOverlapCard(context),
          ),
        ],
      ),
    );
  }

  Widget _settingsOverlapCard(BuildContext context) {
    return Container(
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
          _toggleTile(
            context,
            label: 'Notification',
            value: _notificationsOn,
            onChanged: (v) => setState(() => _notificationsOn = v),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          _navigationTile(
            context,
            label: 'Language',
            trailing: 'English (US)',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Language selection coming soon'),
                ),
              );
            },
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          _toggleTile(
            context,
            label: 'Dark Mode',
            value: _darkModeOn,
            onChanged: (v) => setState(() => _darkModeOn = v),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => showLogoutDialog(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Text(
                      'Logout',
                      style: context.robotoFlexSemiBold(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleTile(
    BuildContext context, {
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _navigationTile(
    BuildContext context, {
    required String label,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
              Text(
                trailing,
                style: context.robotoFlexRegular(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
              4.pw,
              Icon(Icons.chevron_right, color: Colors.grey.shade500, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
