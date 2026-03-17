import '../../export_all.dart';

/// Driver Earning tab. Transaction history / wallet; follows same header pattern.
class DriverEarningTab extends StatelessWidget {
  const DriverEarningTab({super.key});

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
            sectionTitle: 'Earning',
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
                  _buildSummaryCard(context),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction History',
                          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                        ),
                        16.ph,
                        Center(
                          child: Text(
                            'Your earnings and transaction history will appear here.',
                            style: context.robotoFlexRegular(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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

  Widget _buildSummaryCard(BuildContext context) {
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
            Assets.amountDisplayIcon,
            height: 40,
            color: AppColors.primaryColor,
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Earnings',
                  style: context.robotoFlexMedium(fontSize: 14, color: Colors.black87),
                ),
                4.ph,
                Text(
                  '\$3,220',
                  style: context.robotoFlexBold(fontSize: 22, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          CustomButtonWidget(
            label: 'Withdraw',
            onPressed: () {},
            variant: CustomButtonVariant.secondary,
            backgroundColor: const Color(0xff2F2F2F),
            height: 44,
            expandWidth: false,
          ),
        ],
      ),
    );
  }
}
