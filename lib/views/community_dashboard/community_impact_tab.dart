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
          CommunityDashboardHeader(
            sectionTitle: 'Impact',
            onLogout: () {},
          ),
          Positioned(
            top: contentTop,
            left: horizontalPadding,
            right: horizontalPadding,
            child: Container(
              height: context.screenHeight * 0.78,
              color: Colors.transparent,
              child: SingleChildScrollView(
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
            Assets.literIcon,
            width: 32,
            height: 32,
            color: AppColors.primaryColor,
          ),
          12.ph,
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.black54,
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
            Assets.medalIcon,
            width: 56,
            height: 56,
            fit: BoxFit.contain,
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bronze Level',
                  style: context.robotoFlexSemiBold(
                    fontSize: 18,
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
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    final values1 = [450.0, 480.0, 500.0, 520.0, 490.0, 510.0];
    final values2 = [50.0, 80.0, 60.0, 90.0, 70.0, 85.0];
    const maxVal = 600.0;
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
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(months.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 14,
                              height: (values1[i] / maxVal) * 100,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDB932C),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            4.pw,
                            Container(
                              width: 14,
                              height: (values2[i] / maxVal) * 100,
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        8.ph,
                        Text(
                          months[i],
                          style: context.robotoFlexRegular(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
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
      child: Row(
        children: [
          Image.asset(
            Assets.kindraTextLogo,
            width: 72,
            height: 28,
            fit: BoxFit.contain,
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kindra Friendly',
                  style: context.robotoFlexSemiBold(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  'View, Share, and download your certified badge.',
                  style: context.robotoFlexRegular(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56,
            height: 56,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.qr_code_2, size: 36, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
