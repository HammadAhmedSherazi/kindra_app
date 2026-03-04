import '../../export_all.dart';

class CoastalGroupRewardTab extends StatelessWidget {
  const CoastalGroupRewardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.22;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CoastalGroupHeader(
            sectionTitle: 'Reward & Funding',
            height: context.screenHeight * 0.28,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: _SummaryCard(context),
                ),
                16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomButtonWidget(
                          label: 'Withdraw Funds',
                          onPressed: () {},
                          height: 52,
                        ),
                        24.ph,
                        Text(
                          'Total Cleanup Impact',
                          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                        ),
                        12.ph,
                        _ImpactGrid(context),
                        24.ph,
                        Text(
                          'Achievement',
                          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                        ),
                        12.ph,
                        _AchievementTile(
                          title: 'Ocean Ally',
                          subtitle: 'Earned 1,500 eco points!',
                          bgColor: const Color(0xFFFFF8E1),
                        ),
                        10.ph,
                        _AchievementTile(
                          title: 'Eco Warrior',
                          subtitle: 'Completed 5 cleanups!',
                          bgColor: AppColors.primaryColor.withValues(alpha: 0.15),
                        ),
                        24.ph,
                        Text(
                          'Recent Earnings',
                          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                        ),
                        12.ph,
                        _EarningTile(title: 'Clean Earth Foundation', amount: '\$25.00 Sponsorship', date: 'Apr 21'),
                        _EarningTile(title: 'Grants for Green', amount: '\$25.00 Grant', date: 'Apr 8'),
                        _EarningTile(title: 'Anonymous Donor', amount: '\$25.00 Donation', date: 'Apr 8'),
                        100.ph,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _SummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(Assets.environmentImpactIcon, width: 40, height: 40),
                12.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eco Point',
                      style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    4.ph,
                    Text(
                      '2,150',
                      style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(width: 1, height: 50, color: Colors.grey.shade300),
          16.pw,
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '\$',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto Flex',
                      ),
                    ),
                  ),
                ),
                12.pw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Fund',
                      style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                    ),
                    4.ph,
                    Text(
                      '\$37.60',
                      style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ImpactGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ImpactCard(value: '+2,150', label: 'Eco Point Earned'),
        ),
        12.pw,
        Expanded(
          child: _ImpactCard(value: '8', label: 'Cleanups Completed'),
        ),
        12.pw,
        Expanded(
          child: _ImpactCard(value: '33', label: 'Hours Volunteered'),
        ),
      ],
    );
  }
}

class _ImpactCard extends StatelessWidget {
  const _ImpactCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          6.ph,
          Text(
            label,
            style: context.robotoFlexRegular(fontSize: 11, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });

  final String title;
  final String subtitle;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
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
          Image.asset(Assets.medalIcon, width: 40, height: 40),
          14.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.robotoFlexBold(fontSize: 15, color: Colors.black),
                ),
                4.ph,
                Text(
                  subtitle,
                  style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade500),
        ],
      ),
    );
  }
}

class _EarningTile extends StatelessWidget {
  const _EarningTile({
    required this.title,
    required this.amount,
    required this.date,
  });

  final String title;
  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
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
                  title,
                  style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
                ),
                4.ph,
                Text(
                  amount,
                  style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            date,
            style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
