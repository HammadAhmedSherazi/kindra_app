import '../../export_all.dart';
import 'driver_pickup_flow/driver_pickup_flow_shared_widgets.dart';

enum _WalletFilter { all, earnings, withdrawals }

class DriverTransactionHistoryView extends StatefulWidget {
  const DriverTransactionHistoryView({super.key});

  @override
  State<DriverTransactionHistoryView> createState() =>
      _DriverTransactionHistoryViewState();
}

class _DriverTransactionHistoryViewState
    extends State<DriverTransactionHistoryView> {
  _WalletFilter _filter = _WalletFilter.all;

  void _openDetails() {
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
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.26;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 2),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: 'Transaction History',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 250,
            ),
            Positioned(
              top: contentTop,
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWalletStatRow(),
                  14.ph,
                  _buildFilterRow(),
                  18.ph,
                  Expanded(child: SingleChildScrollView(
                    child: Column(
                    
                      children: [
                         Row(
                          spacing: 10,
                           children: [
                            Expanded(child: Divider()),
                             const Text(
                                                   'Feb 2026',
                                                   textAlign: TextAlign.center,
                                                   style: TextStyle(
                                                     fontSize: 14,
                                                     color: Colors.black54,
                                                     fontFamily: 'Roboto Flex',
                                                     fontWeight: FontWeight.w500,
                                                   ),
                                                 ),
                                                 Expanded(child: Divider()),
                           ],
                         ),
                    12.ph,
                    _TransactionHistoryCardList(
                      onTapDetails: _openDetails,
                    ),
                    18.ph,
                    Center(
                      child: SizedBox(
                        width: 140,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(
                            'View More',
                            style: context.robotoFlexMedium(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                    18.ph,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You are already on Transaction History'),
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: const Color(0xff2F2F2F),
                      textColor: Colors.white,
                      variant: CustomButtonVariant.secondary,
                    ),
                                   
                      ],
                    ),
                  ))
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  Widget _buildWalletStatRow() {
    Widget statBlock(String label, String value) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                style: context.robotoFlexRegular(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              4.ph,
              Text(
                value,
                style: context.robotoFlexBold(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        statBlock('Total Earnings', '\$1,250.75'),
        const SizedBox(width: 12),
        statBlock('Total Withdraw', '\$620.50'),
        const SizedBox(width: 12),
        statBlock('Available Balance', '\$630.25'),
      ],
    );
  }

  Widget _buildFilterRow() {
    Widget pill(String label, _WalletFilter value) {
      final selected = _filter == value;
      return Expanded(
        child: InkWell(
          onTap: () => setState(() => _filter = value),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected ? AppColors.primaryColor : Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: context.robotoFlexMedium(
                fontSize: 12,
                color: selected ? AppColors.primaryColor : Colors.black54,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        pill('All', _WalletFilter.all),
        const SizedBox(width: 12),
        pill('Earnings', _WalletFilter.earnings),
        const SizedBox(width: 12),
        pill('Withdrawals', _WalletFilter.withdrawals),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Filters',
              style: context.robotoFlexMedium(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransactionHistoryCardList extends StatelessWidget {
  const _TransactionHistoryCardList({required this.onTapDetails});

  final VoidCallback onTapDetails;

  @override
  Widget build(BuildContext context) {
    const items = [
      ('\$185.75', 'Credited', AppColors.primaryColor),
      ('-\$300.00', 'Completed', Color(0xffE85D3A)),
      ('+\$300.00', 'Credit', AppColors.primaryColor),
      ('-\$300.00', 'Pending', Color(0xffE85D3A)),
      ('-\$300.00', 'Completed', Color(0xffE85D3A)),
    ];

    return Column(
      children: List.generate(items.length, (index) {
        final (amount, status, color) = items[index];
        final isCredit = amount.startsWith('+');
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _TransactionHistoryCard(
            amountText: amount.replaceAll('+', ''),
            isCredit: isCredit,
            statusLabel: status,
            statusColor: color,
            onTap: onTapDetails,
          ),
        );
      }),
    );
  }
}

class _TransactionHistoryCard extends StatelessWidget {
  const _TransactionHistoryCard({
    required this.amountText,
    required this.isCredit,
    required this.statusLabel,
    required this.statusColor,
    required this.onTap,
  });

  final String amountText;
  final bool isCredit;
  final String statusLabel;
  final Color statusColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                Assets.usedCookingOilCard,
                width: 68,
                height: 68,
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
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  4.ph,
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.black54,
                      ),
                      4.pw,
                      Text(
                        'Arcata East',
                        style: context.robotoFlexRegular(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  6.ph,
                  Text(
                    'Today - 9:52 AM',
                    style: context.robotoFlexRegular(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amountText,
                  style: context.robotoFlexBold(
                    fontSize: 14,
                    color:
                        isCredit ? AppColors.primaryColor : const Color(0xffE85D3A),
                  ),
                ),
                6.ph,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusLabel,
                    style: context.robotoFlexMedium(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

