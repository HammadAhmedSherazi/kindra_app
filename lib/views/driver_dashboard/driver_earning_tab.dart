import '../../export_all.dart';

/// Driver Wallet tab UI.
/// Screenshot-matched: Wallet header, balance card, today's earning row,
/// transaction history preview, and bottom actions.
class DriverEarningTab extends StatelessWidget {
  const DriverEarningTab({super.key});

  @override
  Widget build(BuildContext context) {
    final contentTop = communityDashboardStackContentTop(context);
    final horizontalPadding = context.screenWidth * 0.05;
    const bottomButtonsHeight = 124.0;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Driver',
            sectionTitle: 'Wallet',
            showZoneLabel: false,
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: bottomButtonsHeight,
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
                  _buildWalletSummaryCard(context),
                  16.ph,
                  _buildWalletDetailsCard(context),
                ],
              ),
            ),
          ),
          Positioned(
            left: horizontalPadding,
            right: horizontalPadding,
            bottom: 18,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButtonWidget(
                  label: 'Withdraw',
                  onPressed: () {
                    AppRouter.push(
                      const WithdrawFundsView(flowLabel: 'Driver'),
                    );
                  },
                  height: 58,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                ),
                12.ph,
                CustomButtonWidget(
                  label: 'Transaction History',
                  onPressed: () {
                    AppRouter.push(
                      const DriverTransactionHistoryView(),
                    );
                  },
                  height: 58,
                  backgroundColor: const Color(0xff2F2F2F),
                  textColor: Colors.white,
                  variant: CustomButtonVariant.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletSummaryCard(BuildContext context) {
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
          SvgPicture.asset(
            Assets.driverWalletIcon,
            height: 56,
          ),
          18.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$1,250.75',
                  style: context.robotoFlexBold(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                  ),
                ),
                6.ph,
                Text(
                  'Current Wallet Balance',
                  style: context.robotoFlexRegular(
                    fontSize: 14,
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

  Widget _buildWalletDetailsCard(BuildContext context) {
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
            children: [
              Text(
                "Today's Earning",
                style: context.robotoFlexRegular(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Text(
                '\$185.75',
                style: context.robotoFlexBold(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          14.ph,
          Container(height: 1, color: Colors.grey.shade200),
          14.ph,
          Text(
            'Transaction History',
            style: context.robotoFlexRegular(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          12.ph,
          Container(height: 1, color: Colors.grey.shade200),
          16.ph,
          _TransactionPreviewItem(),
        ],
      ),
    );
  }
}

class _TransactionPreviewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.push(
          DriverEarningDetailsView(
            locationTitle: 'Mapco Gas station',
            locationSubtitle: 'Arcata East',
            timeText: 'Today - 9:52 AM',
            imageAsset: Assets.usedCookingOilCard,
            wasteTypeTitle: 'Used Cooking Oil',
            weightKg: '325 kg',
            ratePerKgText: '\$0.57 per kg',
            breakdown: const [
              ('Weight (325 kg)', '+\$185.25'),
              ('Service Fee', '-\$5.00'),
              ('Additional Bonus', '\$20.00'),
            ],
            totalEarnings: '\$200.50',
            transactionId: 'Tq72855918',
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              Assets.usedCookingOilCard,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          12.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mapco Gas station',
                  style: context.robotoFlexBold(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.black54,
                    ),
                    4.pw,
                    Expanded(
                      child: Text(
                        'Arcata East',
                        style: context.robotoFlexRegular(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                6.ph,
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                    ),
                    8.pw,
                    Expanded(
                      child: Text(
                        'Today - 9:52 AM',
                        style: context.robotoFlexRegular(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
