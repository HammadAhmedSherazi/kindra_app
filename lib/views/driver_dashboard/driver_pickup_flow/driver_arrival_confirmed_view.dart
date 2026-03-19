import '../../../export_all.dart';

import 'driver_pickup_flow_shared_widgets.dart';

class DriverArrivalConfirmedView extends StatelessWidget {
  const DriverArrivalConfirmedView({
    super.key,
    required this.data,
    required this.arrivalTime,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: const DriverFlowBottomNavBar(currentIndex: 1),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: '',
              showZoneLabel: false,
              onLogout: () {},
              showNotificationIcon: true,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              height: 180,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: MediaQuery.paddingOf(context).top + 8,
                          left: 12,
                          child: GestureDetector(
                            onTap: () => AppRouter.back(),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            20.ph,
                            const ArrivalGraphic(),
                      
                            
                            40.ph,
                            Text(
                              'Arrived at $arrivalTime',
                              style: context.robotoFlexRegular(
                                fontSize: 18,
                                
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    18.ph,
                    PickupLocationCard(data: data),
                    20.ph,
                    CustomButtonWidget(
                      label: 'Start Collection',
                      onPressed: () {
                        AppRouter.push(
                          DriverEnterCollectedQuantityView(
                            data: data,
                            arrivalTime: arrivalTime,
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                    ),
                    12.ph,
                    CustomButtonWidget(
                      label: 'Report Issue',
                      onPressed: () {
                        AppRouter.push(const DriverReportIssueView());
                      },
                      height: 58,
                      backgroundColor: const Color(0xff2F2F2F),
                      textColor: Colors.white,
                      variant: CustomButtonVariant.secondary,
                    ),
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
