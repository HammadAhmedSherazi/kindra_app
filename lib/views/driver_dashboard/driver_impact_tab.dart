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
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildImpactStatCard(
                          context,
                          icon: Assets.dropIcon,
                          value: '1230',
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
                  _buildTotalOilCollectedCard(context),
                  16.ph,
                  _buildThisMonthCompletedPickupsCard(context),
                  24.ph,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalOilCollectedCard(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values = [450.0, 480.0, 470.0, 490.0, 490.0, 500.0];
    const totalLiters = '2,730 Liters';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Oil Collected',
                style: context.robotoFlexSemiBold(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Text(
                totalLiters,
                style: context.robotoFlexSemiBold(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          20.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BarChartWidget(
              labels: months,
              series: [
                BarChartSeries(
                  values: values,
                  color: const Color(0xFFE5A842),
                ),
              ],
              maxY: 600,
              yTickCount: 5,
              barRadius: 6,
              barGap: 6,
              darkTheme: false,
              chartHeight: 220,
              yLabelFormat: (v) =>
                  v >= 1000 ? '${(v / 1000).toStringAsFixed(0)}K' : v.toStringAsFixed(0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThisMonthCompletedPickupsCard(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values = [75.0, 80.0, 78.0, 82.0, 81.0, 85.0];

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'This Month Completed Pickups',
            style: context.robotoFlexSemiBold(fontSize: 16, color: Colors.black),
          ),
          4.ph,
          Text(
            '15 pickup Reduced',
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.black.withValues(alpha: 0.7)),
          ),
          16.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LineChartWidget(
              labels: months,
              values: values,
              color: const Color(0xFF2196F3),
              maxY: 100,
              yTickCount: 5,
              chartHeight: 220,
              pointRadius: 5,
              lineWidth: 2.5,
              yLabelFormat: (v) => v.toStringAsFixed(0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(icon, height: 38, color: AppColors.primaryColor),
          12.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
          ),
          2.ph,
          Text(
            subLabel,
            style: context.robotoFlexRegular(fontSize: 12, color: Colors.black54),
          ),
          Text(
            label,
            style: context.robotoFlexRegular(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
