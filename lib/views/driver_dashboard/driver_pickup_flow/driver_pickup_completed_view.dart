import '../../../export_all.dart';

import 'driver_calculating_payment_view.dart';
import 'driver_pickup_flow_shared_widgets.dart';

class DriverPickupCompletedView extends StatelessWidget {
  const DriverPickupCompletedView({
    super.key,
    required this.data,
    required this.arrivalTime,
    required this.collectedLiters,
  });

  final DriverPickupRequestData data;
  final String arrivalTime;
  final double collectedLiters;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final litersLabel =
        collectedLiters == collectedLiters.roundToDouble()
            ? collectedLiters.round().toString()
            : collectedLiters.toStringAsFixed(1);

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
                  20.ph,
                  const SuccessBubblesCheckGraphic(),
                  16.ph,
                  Text(
                    'Pickup Completed!',
                    style: context.robotoFlexBold(fontSize: 26, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  16.ph,
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LabelValueRow(label: 'Arrival Time', value: arrivalTime),
                        12.ph,
                        Text(
                          'Collected',
                          style: context.robotoFlexSemiBold(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        10.ph,
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                data.imageAsset,
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
                                    '$litersLabel Liters',
                                    style: context.robotoFlexBold(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  2.ph,
                                  Text(
                                    'Used Cooking Oil',
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
                        18.ph,
                        Text(
                          'Business',
                          style: context.robotoFlexSemiBold(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        10.ph,
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  data.imageAsset,
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
                                      data.locationName,
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
                                          size: 14,
                                          color: Colors.grey,
                                        ),
                                        4.pw,
                                        Expanded(
                                          child: Text(
                                            data.areaName,
                                            style: context.robotoFlexRegular(
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    4.ph,
                                    Text(
                                      data.fullAddress,
                                      style: context.robotoFlexRegular(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        18.ph,
                        CustomButtonWidget(
                          label: 'Done',
                          onPressed: () {
                            AppRouter.push(const DriverCalculatingPaymentView());
                          },
                          height: 54,
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  6.ph,
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: MediaQuery.paddingOf(context).top + 8,
          //   left: 12,
          //   child: GestureDetector(
          //     onTap: () => AppRouter.back(),
          //     child: const Padding(
          //       padding: EdgeInsets.all(8),
          //       child: Icon(
          //         Icons.arrow_back_ios_new,
          //         color: Colors.white,
          //         size: 22,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

}
