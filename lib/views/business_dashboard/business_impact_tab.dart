import '../../export_all.dart';

/// Impact tab for business dashboard.
/// Follows community_impact_tab structure with business-specific cards:
/// Liters Collected, Pollution Prevented, Total Oil Collected (bar chart),
/// CO2 Reduction (line chart), Kindra Friendly.
class BusinessImpactTab extends StatelessWidget {
  const BusinessImpactTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: 0.23,
    );

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Business Dashboard',
            sectionTitle: 'Impact',
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: horizontalPadding,
            right: horizontalPadding,
            child: Container(
              height: context.screenHeight * 0.78,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildImpactCard(
                          context,
                          '1230',
                          'Liters Collected',
                        ),
                      ),
                      12.pw,
                      Expanded(
                        child: _buildImpactCard(
                          context,
                          '~3,200 KG',
                          'Pollution Prevented',
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(bottom: 200),
                      children: [
                        16.ph,
                        _buildTotalOilCollectedCard(context),
                        16.ph,
                        _buildCO2ReductionCard(context),
                        16.ph,
                        KindraFriendlyCard(),
                        24.ph,
                      ],
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

  Widget _buildImpactCard(BuildContext context, String value, String label) {
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
          Image.asset(
            Assets.dropIcon,
            width: 41,
            height: 41,
          ),
          12.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 30, color: Colors.black),
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalOilCollectedCard(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values1 = [455.0, 485.0, 475.0, 495.0, 495.0, 505.0];
    const values2 = [50.0, 50.0, 50.0, 40.0, 40.0, 30.0];
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  values: values1,
                  color: const Color(0xFFE5A842),
                ),
                BarChartSeries(
                  values: values2,
                  color: const Color(0xFF0A4D59),
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

  Widget _buildCO2ReductionCard(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values = [75.0, 82.0, 85.0, 70.0, 85.0, 92.0];
    const totalReduced = '1,474 kg Reduced';
    const deltaText = '+368 Kg';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CO2 Reduction',
                style: context.robotoFlexSemiBold(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalReduced,
                    style: context.robotoFlexSemiBold(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  2.ph,
                  Text(
                    deltaText,
                    style: context.robotoFlexMedium(
                      fontSize: 13,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ],
          ),
          20.ph,
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
}
