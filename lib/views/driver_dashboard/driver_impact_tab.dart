import '../../export_all.dart';

/// Driver Impact tab. Liters collected, completed pickups; follows same header pattern.
class DriverImpactTab extends StatelessWidget {
  const DriverImpactTab({super.key});

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
            sectionTitle: 'Impact',
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
                  Row(
                    children: [
                      Expanded(
                        child: _buildImpactStatCard(
                          context,
                          icon: Assets.dropIcon,
                          value: '1,230',
                          subLabel: 'This Month',
                          label: 'Liters Collected',
                        ),
                      ),
                      12.pw,
                      Expanded(
                        child: _buildImpactStatCard(
                          context,
                          icon: Assets.kindraLeaveIcon,
                          value: '4,250',
                          subLabel: 'This Month',
                          label: 'Completed Pickups',
                        ),
                      ),
                    ],
                  ),
                  16.ph,
                  Container(
                    padding: const EdgeInsets.all(24),
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
                    child: Center(
                      child: Text(
                        'Charts and impact details will appear here.',
                        style: context.robotoFlexRegular(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStatCard(
    BuildContext context, {
    required String icon,
    required String value,
    required String subLabel,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(icon, height: 36, color: AppColors.primaryColor),
          12.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
          ),
          2.ph,
          Text(
            subLabel,
            style: context.robotoFlexRegular(fontSize: 12, color: Colors.black54),
          ),
          Text(
            label,
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
