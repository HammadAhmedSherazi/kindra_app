import '../../export_all.dart';
import 'driver_pickup_detail_view.dart';

/// Driver Requests tab: list of pickup requests. Tapping a card opens Pickup Detail.
/// Accept/Reject dialogs follow the same style as the previously created dialogs.
class DriverRequestsTab extends StatelessWidget {
  const DriverRequestsTab({super.key});

  static final List<DriverPickupRequestData> _demoRequests = [
    const DriverPickupRequestData(
      locationName: 'Mapco Gas station',
      areaName: 'Arcata East',
      fullAddress: 'Street 4, Road 8, USA',
      timeSlot: '9:00 AM - 10:00 AM',
      quantity: '800 Liters',
      imageAsset: Assets.usedCookingOilCard,
      distanceKm: '4',
    ),
    const DriverPickupRequestData(
      locationName: 'Mapco Gas station',
      areaName: 'Arcata East',
      fullAddress: 'Street 4, Road 8, USA',
      timeSlot: '9:00 AM - 10:00 AM',
      quantity: '800 Liters',
      imageAsset: Assets.usedCookingOilCard,
      distanceKm: '4',
    ),
    const DriverPickupRequestData(
      locationName: 'Mapco Gas station',
      areaName: 'Arcata East',
      fullAddress: 'Street 4, Road 8, USA',
      timeSlot: '11:00 AM - 12:00 PM',
      quantity: '500 Liters',
      imageAsset: Assets.usedCookingOilCard,
      distanceKm: '6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final contentTop = context.screenHeight * 0.22;
    final horizontalPadding = context.screenWidth * 0.05;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Driver',
            sectionTitle: 'Requests',
            showZoneLabel: false,
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
              itemCount: _demoRequests.length,
              itemBuilder: (context, index) {
                final data = _demoRequests[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _PickupRequestCard(
                    data: data,
                    onTap: () => AppRouter.push(DriverPickupDetailView(data: data)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PickupRequestCard extends StatelessWidget {
  const _PickupRequestCard({
    required this.data,
    required this.onTap,
  });

  final DriverPickupRequestData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    data.imageAsset,
                    width: 72,
                    height: 72,
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
                        style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                      ),
                      6.ph,
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600),
                          4.pw,
                          Text(
                            data.areaName,
                            style: context.robotoFlexRegular(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                      4.ph,
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                          4.pw,
                          Text(
                            data.timeSlot,
                            style: context.robotoFlexRegular(fontSize: 12, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  data.quantity,
                  style: context.robotoFlexSemiBold(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
            12.ph,
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    label: 'Accept',
                    onPressed: () => onTap(),
                    variant: CustomButtonVariant.secondary,
                    backgroundColor: const Color(0xff2F2F2F),
                    height: 40,
                    expandWidth: false,
                  ),
                ),
                12.pw,
                Expanded(
                  child: CustomButtonWidget(
                    label: 'Reject',
                    onPressed: () => onTap(),
                    variant: CustomButtonVariant.secondary,
                    backgroundColor: const Color(0xffE85D3A),
                    height: 40,
                    expandWidth: false,
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
