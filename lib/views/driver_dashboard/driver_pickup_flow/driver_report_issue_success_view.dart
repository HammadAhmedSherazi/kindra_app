import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverReportIssueSuccessView extends StatelessWidget {
  const DriverReportIssueSuccessView({super.key});

  static const Color _headerBg = Color(0xFFFFE8BE);

  void _returnToDashboard() {
    AppRouter.pushAndRemoveUntil(const DriverDashboardView(initialIndex: 1));
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 1),
      body: Column(
        children: [
          CommunityDashboardHeader(
            subtitle: 'Driver',
            sectionTitle: '',
            showZoneLabel: false,
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
            height: 180,
            backgroundColor: _headerBg,
            logoAsset: Assets.kindraTextLogo,
            subtitleColor: Colors.black87,
            sideActionLabelColor: Colors.black87,
            logoutTextColor: Colors.black87,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                8,
                horizontalPadding,
                120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  12.ph,
                  const ReportIssueWarningGraphic(),
                  20.ph,
                  Text(
                    'Issue Reported',
                    style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
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
                  Container(
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
                    child: CustomButtonWidget(
                      label: 'Return to Dashboard',
                      onPressed: _returnToDashboard,
                      height: 54,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
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
}
