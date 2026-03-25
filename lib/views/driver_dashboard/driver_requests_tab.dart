import '../../export_all.dart';

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
    final contentTop = communityDashboardStackContentTop(context);
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
                  child: DriverPickupRequestCard(
                    data: data,
                    onTap: () =>
                        AppRouter.push(DriverPickupDetailView(data: data)),
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
