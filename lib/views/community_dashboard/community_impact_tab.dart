import '../../export_all.dart';

class CommunityImpactTab extends StatelessWidget {
  const CommunityImpactTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.23;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(sectionTitle: 'Impact', onLogout: () {}),
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
                        _buildBronzeLevelCard(context),
                        16.ph,
                        _buildMonthlyStatsCard(context),
                        16.ph,
                        GestureDetector(
                          onTap: () =>
                              AppRouter.push(const KindraFriendlyView()),
                          child: _buildKindraFriendlyCard(context),
                        ),
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
            // color: AppColors.primaryColor,
          ),
          12.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 30, color: Colors.black),
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(
              fontSize: 14,
              // color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBronzeLevelCard(BuildContext context) {
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
          Image.asset(
            Assets.loyalRankIcon,
            width: 80,
            height: 80,
            // fit: BoxFit.contain,
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bronze Level',
                  style: context.robotoFlexSemiBold(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                8.ph,
                Text(
                  'Current : Bronze',
                  style: context.robotoFlexRegular(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                8.ph,
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                ),
                6.ph,
                Text(
                  'Next Rank: Silver',
                  style: context.robotoFlexRegular(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyStatsCard(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values1 = [450.0, 480.0, 470.0, 490.0, 490.0, 500.0];
    const values2 = [50.0, 50.0, 50.0, 40.0, 40.0, 30.0];
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
          Text(
            'Monthly Stats',
            style: context.robotoFlexSemiBold(
              fontSize: 18,
              color: Colors.black,
            ),
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
              yLabelFormat: (v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(0)}K' : v.toStringAsFixed(0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKindraFriendlyCard(BuildContext context) {
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.kindraTextLogo,

                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    16.pw,
                    Text(
                      'Kindra Friendly',
                      style: context.robotoFlexSemiBold(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.qr_code_2, size: 130, color: Colors.black),
            ],
          ),
          // 4.ph,
          Text(
            'View, Share, and download your certified badge.',
            style: context.robotoFlexMedium(
              fontSize: 15,
              // color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
