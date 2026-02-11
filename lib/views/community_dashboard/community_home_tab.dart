import '../../export_all.dart';

class CommunityHomeTab extends StatelessWidget {
  const CommunityHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final oilCardTop = context.screenHeight * 0.22;
    final gridTop = context.screenHeight * 0.39;
    final itemWidth = (context.screenWidth - horizontalPadding * 2 - 12) / 2;
    final itemHeight = context.screenHeight * 0.18;
    final gridAspectRatio = (itemWidth / itemHeight).clamp(0.7, 1.05);

    return SizedBox(
          // padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            clipBehavior: Clip.none,
            children: [
              CommunityDashboardHeader(onLogout: () {}),
              Positioned(
                top: oilCardTop,
                left: horizontalPadding,
                right: horizontalPadding,
                child: _buildOilCollectedCard(context),
              ),
              Positioned(
                top: gridTop,
                left: horizontalPadding,
                right: horizontalPadding,
                child: Container(
                  height: context.screenHeight * 0.50,
                  padding: EdgeInsets.only(
                    // bottom: 300,
                  ),
                  child: SingleChildScrollView(
                   
                    child: Column(
                      spacing: 20,
                      children: [
                        GridView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          clipBehavior: Clip.none,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: gridAspectRatio,
                          ),
                          children: [
                            _buildCommunityMembersCard(context),
                            _buildEnvironmentalImpactCard(context),
                            _buildNextPickupCard(context),
                            _buildLoyaltyRankCard(context),
                          ],
                        ),
                        _buildMonthlyStatsCard(context),
                        _buildKindraFriendlyCard(context),
                      ],
                    ),
                  ),
                ),
              )
            
              
            ],
          ),
        )
      ;
  }

  Widget _buildOilCollectedCard(BuildContext context) {
    const currentL = 275;
    const goalL = 500;
    final progress = currentL / goalL;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15
      ),
      // height: 300,
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
                'Oil Collected',
                style: context.robotoFlexSemiBold(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.signal_cellular_alt, size: 24, color: Color(0xffD9D9D9)),
            ],
          ),
          // 12.ph,
          Text.rich(
            TextSpan(
              style: context.robotoFlexRegular(
                fontSize: 14,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '$currentL L  ',
                  style: context.robotoFlexBold(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(text: '/ $goalL L Minimum Goal'),
              ],
            ),
          ),
          12.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          ),
          6.ph,
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                '${(progress * 100).toInt()}% to Goal',
                style: context.robotoFlexRegular(
                  fontSize: 12,
                  color: const Color.fromARGB(221, 81, 79, 79),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityMembersCard(BuildContext context) {
    return _DashboardCard(
      icon: Assets.communityMemberIcon,
      title: 'Community Members',
      children: [
        _cardRow('Total Householder', '85'),
                // 8.ph,
        _cardRow('Active Contributors', '42'),
      ],
    );
  }

  Widget _buildEnvironmentalImpactCard(BuildContext context) {
    return _DashboardCard(
      icon: Assets.environmentImpactIcon,
      title: 'Environmental Impact',
      children: [
        _cardRow('275 L Collected', ''),
                // 8.ph,
        _cardRow('220 kg Pollution Prevented', ''),
      ],
    );
  }

  Widget _cardRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label ,
            maxLines: 1 ,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
             value,
            maxLines: 1 ,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
      ],
    );
  }

  Widget _buildNextPickupCard(BuildContext context) {
    return _DashboardCard(
      icon: Assets.nextPickupIcon,
      color: AppColors.primaryColor,
      title: 'Next Pickup',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.checkedIcon, width: 12, height: 12, color: Colors.white),
            4.pw,
            Text(
              'Scheduled',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      children: [
       
        Text(
          'Tuesday, May 12',
          style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black),
        ),
       
        Text(
          '10:00 AM - 12:00 PM',
          style: context.robotoFlexRegular(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildLoyaltyRankCard(BuildContext context) {
    return _DashboardCard(
      icon: Assets.loyalRankIcon,
      title: 'Loyalty & Rank',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '320 Points',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      children: [
        Text(
          'Current : Bronze',
          style: context.robotoFlexRegular(fontSize: 13, color: Colors.black87),
        ),
        8.ph,
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: 0.6,
            minHeight: 8,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
        6.ph,
        Text(
          'Next Rank: Silver',
          style: context.robotoFlexRegular(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildMonthlyStatsCard(BuildContext context) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    final values1 = [420.0, 380.0, 450.0, 500.0, 480.0, 520.0];
    final values2 = [80.0, 120.0, 90.0, 100.0, 110.0, 95.0];
    final maxVal = 600.0;
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
            style: context.robotoFlexSemiBold(fontSize: 18, color: Colors.black),
          ),
          20.ph,
          SizedBox(
            height: 180,
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
                              width: 12,
                              height: (values1[i] / maxVal) * 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDB932C),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            4.pw,
                            Container(
                              width: 12,
                              height: (values2[i] / maxVal) * 120,
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
    return GestureDetector(
      onTap: () => AppRouter.push(const KindraFriendlyView()),
      child: Container(
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
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
              Assets.kindraTextLogo,
              // width: 100,
              height: 60,
              // fit: BoxFit.contain,
            ),
            16.pw,
                  Text(
                    'Kindra Friendly',
                    style: context.robotoFlexSemiBold(fontSize: 25, color: Colors.black),
                  ),
                  4.ph,
                  Text(
                    'Verified Partner',
                    style: context.robotoFlexSemiBold(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
            Icon(Icons.qr_code_2, size: 115, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.icon,
    required this.title,
    this.trailing,
    required this.children,
    this.color
  });

  final String icon;
  final String title;
  final Widget? trailing;
  final Color? color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
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
        // spacing: 2,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                // width: 45,
                height: 38,
                color:  color,
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          8.ph,
          Text(
            title,
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          3.ph,
          ...children,
        ],
      ),
    );
  }
}
