import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverReportIssueSuccessView extends StatelessWidget {
  const DriverReportIssueSuccessView({super.key});

  void _returnToDashboard() {
    AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 1));
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: 0.20,
      hasSectionTitle: false,
    );
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
              height: 280,
              backgroundColor: AppColors.primaryColor,
              logoAsset: Assets.kindraTextWhiteLogo,
              subtitleColor: Colors.white,
              sideActionLabelColor: Colors.white,
              logoutTextColor: Colors.white,
            ),
            Positioned(
              top: contentTop,
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
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
                        12.ph,
                        const SuccessBubblesCheckGraphic(),
                        14.ph,
                        Text(
                          'Issue Reported',
                          style: context.robotoFlexBold(
                            fontSize: 26,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        12.ph,
                        Text(
                          'Your issue has been reported successfully.',
                          style: context.robotoFlexRegular(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        28.ph,
                        CustomButtonWidget(
                          label: 'Return to Dashboard',
                          onPressed: _returnToDashboard,
                          height: 54,
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
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
