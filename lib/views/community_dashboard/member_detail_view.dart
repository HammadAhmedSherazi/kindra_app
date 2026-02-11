import '../../export_all.dart';

class MemberDetailView extends StatelessWidget {
  const MemberDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BackButtonWidget(onPressed: () => AppRouter.back()),
        ),
        title: Text(
          'Members',
          style: context.robotoFlexSemiBold(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(Assets.userAvatar),
            ),
            16.ph,
            Text(
              'Sarah Ali',
              style: context.robotoFlexSemiBold(fontSize: 22, color: Colors.black),
            ),
            4.ph,
            Text(
              'Householder ID #01872',
              style: context.robotoFlexRegular(fontSize: 14, color: Colors.black54),
            ),
            4.ph,
            Text(
              'Status: Active',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            24.ph,
            _buildContributionCard(context),
            16.ph,
            _buildEcoPointsCard(context),
            20.ph,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Activity History',
                style: context.robotoFlexSemiBold(fontSize: 18, color: Colors.black),
              ),
            ),
            12.ph,
            _buildActivityItem(context, 'Apr 14, 2025', '40 liters', 'Verified', 40),
            8.ph,
            _buildActivityItem(context, 'Apr 14, 2025', '40 liters', 'Verified', 40),
            8.ph,
            _buildActivityItem(context, 'Apr 14, 2025', '40 liters', 'Verified', 40),
            24.ph,
            CustomButtonWidget(
              label: 'View Full History',
              onPressed: () {},
            ),
            12.ph,
            CustomButtonWidget(
              label: 'Back Home',
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const CommunityDashboardView(initialIndex: 0),
                  ),
                  (route) => false,
                );
              },
            ),
            24.ph,
          ],
        ),
      ),
    );
  }

  Widget _buildContributionCard(BuildContext context) {
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
            children: [
              Image.asset(
                Assets.literIcon,
                width: 36,
                height: 36,
                color: AppColors.primaryColor,
              ),
              12.pw,
              Text(
                '22.5 Liters',
                style: context.robotoFlexSemiBold(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          12.ph,
          Text(
            'Last Contribution : Apr 14, 2025',
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.black54),
          ),
          8.ph,
          Row(
            children: [
              Image.asset(
                Assets.literIcon,
                width: 20,
                height: 20,
                color: Colors.grey,
              ),
              6.pw,
              Text(
                '12 Liters / Month',
                style: context.robotoFlexRegular(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEcoPointsCard(BuildContext context) {
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
            children: [
              Image.asset(
                Assets.literIcon,
                width: 36,
                height: 36,
                color: AppColors.primaryColor,
              ),
              12.pw,
              Text(
                '135 Points',
                style: context.robotoFlexSemiBold(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          12.ph,
          Text(
            'Eco-Points Redeemed: 45 Points',
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String date,
    String quantity,
    String verification,
    int points,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: context.robotoFlexSemiBold(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  quantity,
                  style: context.robotoFlexRegular(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              verification,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          8.pw,
          Text(
            '$points points',
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
