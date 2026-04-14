import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverProcessingPaymentView extends StatefulWidget {
  const DriverProcessingPaymentView({super.key});

  @override
  State<DriverProcessingPaymentView> createState() =>
      _DriverProcessingPaymentViewState();
}

class _DriverProcessingPaymentViewState extends State<DriverProcessingPaymentView> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      if (!mounted) return;
      AppRouter.push(const DriverEarningsUpdatedView());
    });
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
              left: 0,
              right: 0,
              bottom: 0,
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
                    Text(
                      'Processing payment...',
                      style: context.robotoFlexBold(fontSize: 26, color: Colors.white),
                    ),
                    18.ph,
                    const PaymentProcessingCard(title: 'Processing payment...'),
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
