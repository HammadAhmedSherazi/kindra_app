import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverCalculatingPaymentView extends StatefulWidget {
  const DriverCalculatingPaymentView({super.key});

  @override
  State<DriverCalculatingPaymentView> createState() =>
      _DriverCalculatingPaymentViewState();
}

class _DriverCalculatingPaymentViewState
    extends State<DriverCalculatingPaymentView> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      if (!mounted) return;
      AppRouter.push(const DriverProcessingPaymentView());
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
                      'Calculating payment...',
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
