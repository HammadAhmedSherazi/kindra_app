import '../../export_all.dart';

class MemberDetailView extends StatelessWidget {
  const MemberDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: 'Members',
      child: SingleChildScrollView(
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
                style: context.robotoFlexSemiBold(fontSize: 22, color: Colors.black),
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
              backgroundColor: Colors.grey.shade400,
              variant: CustomButtonVariant.primary,
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
         
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 15,
            children: [
              Image.asset(
                Assets.dropIcon,
                width: 36,
                height: 36,
                color: AppColors.primaryColor,
              ),
             
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '22.5 Liters',
                      style: context.robotoFlexSemiBold(
                        fontSize: 26,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Last Contribution : Apr 14, 2025',
                      style: context.robotoFlexMedium(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        
          
          12.ph,
          Divider(height: 1, color: Colors.black.withValues(alpha: 0.12)),
          12.ph,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10
            ),
            child: Row(
              spacing: 15,
              children: [
                Image.asset(
                  Assets.dropIcon,
                  width: 20,
                  height: 20,
                  color: Colors.black45,
                ),
               
                Text(
                  '12 Liters / Month',
                  style: context.robotoFlexRegular(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEcoPointsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.dropIcon,
                width: 36,
                height: 36,
                color: AppColors.primaryColor,
              ),
              12.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '135 Points',
                      style: context.robotoFlexSemiBold(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Eco-Points Redeemed: 45 Points',
                      style: context.robotoFlexMedium(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
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
        color:  Colors.white,
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
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  quantity,
                  style: context.robotoFlexRegular(
                    fontSize: 16,
                    color: Colors.black87,
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
            style: context.robotoFlexSemiBold(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
