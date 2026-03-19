import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverEarningsUpdatedView extends StatelessWidget {
  const DriverEarningsUpdatedView({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.18;

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 330,
            ),
            Positioned(
              top: contentTop,
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Pickup Completed!',
                    style: context.robotoFlexBold(fontSize: 26, color: Colors.white),
                  ),
                  14.ph,
                  _EarningsCard(
                    amountEarnedText: '\$185.75',
                    locationTitle: 'Mapco Gas station',
                    locationSubtitle: 'Arcata East',
                    timeText: 'Today - 9:52 AM',
                  ),
                  18.ph,
                  CustomButtonWidget(
                    label: 'View Wallet',
                    onPressed: () {
                      AppRouter.pushAndRemoveUntil(
                        const DriverDashboardView(initialIndex: 2),
                      );
                    },
                    height: 58,
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                  12.ph,
                  CustomButtonWidget(
                    label: 'Back to Dashboard',
                    onPressed: () {
                      AppRouter.pushAndRemoveUntil(
                        const DriverDashboardView(initialIndex: 1),
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
      ),
    );
  }
}

class _EarningsCard extends StatelessWidget {
  const _EarningsCard({
    required this.amountEarnedText,
    required this.locationTitle,
    required this.locationSubtitle,
    required this.timeText,
  });

  final String amountEarnedText;
  final String locationTitle;
  final String locationSubtitle;
  final String timeText;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SuccessBubblesCheckGraphic(small: true),
          12.ph,
          Text(
            'Earnings Updated!',
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          16.ph,
          Text(
            'Amount Earned: $amountEarnedText',
            style: context.robotoFlexBold(fontSize: 24, color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          16.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
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
                      style: context.robotoFlexSemiBold(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    4.ph,
                    Text(
                      locationSubtitle,
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    6.ph,
                    Text(
                      timeText,
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.ph,
          Text(
            'Added to wallet Successfully!',
            style: context.robotoFlexMedium(fontSize: 16, color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
