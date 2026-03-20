import '../../export_all.dart';

import 'driver_pickup_flow/driver_pickup_flow_shared_widgets.dart';

class DriverEarningDetailsView extends StatelessWidget {
  const DriverEarningDetailsView({
    super.key,
    required this.locationTitle,
    required this.locationSubtitle,
    required this.timeText,
    required this.imageAsset,
    required this.wasteTypeTitle,
    required this.weightKg,
    required this.ratePerKgText,
    required this.breakdown,
    required this.totalEarnings,
    required this.transactionId,
  });

  final String locationTitle;
  final String locationSubtitle;
  final String timeText;
  final String imageAsset;
  final String wasteTypeTitle;
  final String weightKg;
  final String ratePerKgText;
  final List<(String, String)> breakdown;
  final String totalEarnings;
  final String transactionId;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.22;

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
              sectionTitle: 'Earning Details',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 220,
            ),
            Positioned(
              top: contentTop,
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: 0,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
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
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.primaryColor,
                                size: 22,
                              ),
                              10.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      locationTitle,
                                      style: context.robotoFlexBold(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    2.ph,
                                    Text(
                                      locationSubtitle,
                                      style: context.robotoFlexRegular(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    2.ph,
                                    Text(
                                      timeText,
                                      style: context.robotoFlexRegular(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.ph,
                    _InfoRowCard(
                      title: 'Waste Type',
                      imageAsset: imageAsset,
                      value: wasteTypeTitle,
                      subtitle: 'Used Cooking Oil',
                    ),
                    14.ph,
                    _KeyValueCard(
                      leftTitle: 'Weight',
                      value: weightKg,
                      imageAsset: imageAsset,
                    ),
                    14.ph,
                    _KeyValueCard(
                      leftTitle: 'Rate per kg',
                      value: ratePerKgText,
                      imageAsset: imageAsset,
                    ),
                    18.ph,
                    _BreakdownCard(
                      breakdown: breakdown,
                      totalEarnings: totalEarnings,
                    ),
                    18.ph,
                    CustomButtonWidget(
                      label: 'Added to Wallet',
                      onPressed: () {},
                      height: 56,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                    14.ph,
                    Text(
                      'Transaction ID: $transactionId',
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    18.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRowCard extends StatelessWidget {
  const _InfoRowCard({
    required this.title,
    required this.imageAsset,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String imageAsset;
  final String value;
  final String subtitle;

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
        children: [
          Text(
            title,
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          10.ph,
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageAsset,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              12.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: context.robotoFlexBold(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    3.ph,
                    Text(
                      subtitle,
                      style: context.robotoFlexRegular(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
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
}

class _KeyValueCard extends StatelessWidget {
  const _KeyValueCard({
    required this.leftTitle,
    required this.value,
    required this.imageAsset,
  });

  final String leftTitle;
  final String value;
  final String imageAsset;

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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageAsset,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          12.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftTitle,
                  style: context.robotoFlexRegular(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                6.ph,
              ],
            ),
          ),
          Text(
            value,
            style: context.robotoFlexBold(
              fontSize: 14,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({
    required this.breakdown,
    required this.totalEarnings,
  });

  final List<(String, String)> breakdown;
  final String totalEarnings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffD3FFC4),
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
          Text(
            'Total Earning Breakdown',
            style: context.robotoFlexBold(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          12.ph,
          ...breakdown.map((row) {
            final (label, value) = row;
            final isNegative = value.trim().startsWith('-');
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: context.robotoFlexRegular(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    value,
                    style: context.robotoFlexBold(
                      fontSize: 13,
                      color: isNegative ? const Color(0xffE85D3A) : AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }),
          6.ph,
          Divider(color: Colors.black.withValues(alpha: 0.08)),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Earnings',
                style: context.robotoFlexBold(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              Text(
                totalEarnings,
                style: context.robotoFlexBold(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

