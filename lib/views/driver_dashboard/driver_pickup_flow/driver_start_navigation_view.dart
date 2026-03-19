import '../../../export_all.dart';

import 'driver_arrival_confirmed_view.dart';
import 'driver_pickup_flow_shared_widgets.dart';

class DriverStartNavigationView extends StatelessWidget {
  const DriverStartNavigationView({super.key, required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;

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
              child: Stack(
                alignment: AlignmentGeometry.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    // top: contentTop,
                    // left: 0,
                    // right: 0,
                    // bottom: 0,
                    child: RouteMapPlaceholder(data: data),
                  ),
                  Positioned(
                    bottom: 100,
                    left: horizontalPadding,
                    right: horizontalPadding,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
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
                                  data.imageAsset,
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              12.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.locationName,
                                      style: context.robotoFlexBold(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    4.ph,
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        4.pw,
                                        Expanded(
                                          child: Text(
                                            data.areaName,
                                            style: context.robotoFlexRegular(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '4 min',
                                    style: context.robotoFlexBold(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  4.ph,
                                  Text(
                                    '1 miles',
                                    style: context.robotoFlexRegular(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 20,
                    child: CustomButtonWidget(
                      label: 'Mark as Arrived',
                      onPressed: () {
                        AppRouter.push(
                          DriverArrivalConfirmedView(
                            data: data,
                            arrivalTime: '9:52 AM',
                          ),
                        );
                      },
                      height: 58,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
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
