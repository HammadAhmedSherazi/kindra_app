
import '../../export_all.dart';

/// Data for a driver pickup request (used in list and detail).
class DriverPickupRequestData {
  const DriverPickupRequestData({
    required this.locationName,
    required this.areaName,
    required this.fullAddress,
    required this.timeSlot,
    required this.quantity,
    required this.imageAsset,
    this.distanceKm = '4',
  });

  final String locationName;
  final String areaName;
  final String fullAddress;
  final String timeSlot;
  final String quantity;
  final String imageAsset;
  final String distanceKm;
}

/// Full-screen Pickup Detail: location card, map placeholder, time slot, oil quantity,
/// Start Navigation, Accept, Reject. Dialogs follow the same style as before.
class DriverPickupDetailView extends StatelessWidget {
  const DriverPickupDetailView({
    super.key,
    required this.data,
  });

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = communityDashboardStackContentTop(context);

    return Scaffold(
      backgroundColor: Color(0xffF9FAFC),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Driver',
              sectionTitle: 'Pickup Detail',
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
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLocationCard(context),
                    16.ph,
                    _buildMapPlaceholder(context),
                    16.ph,
                    _buildInfoCard(
                      context,
                      icon: Icons.access_time_rounded,
                      title: 'Pickup Time Slot',
                      value: data.timeSlot,
                    ),
                    12.ph,
                    _buildInfoCard(
                      context,
                      imagePath: 'assets/icons/liter_icon.png',
                      title: 'Used Cooking Oil',
                      value: data.quantity,
                    ),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Start Navigation',
                      onPressed: () {
                        AppRouter.push(DriverStartNavigationView(data: data));
                      },
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      height: 52,
                    ),
                    16.ph,
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWidget(
                            label: 'Accept',
                            onPressed: () => showAcceptPickupDialog(
                              context,
                              onConfirm: () => AppRouter.back(),
                            ),
                            variant: CustomButtonVariant.secondary,
                            backgroundColor: const Color(0xff2F2F2F),
                            height: 48,
                            expandWidth: false,
                          ),
                        ),
                        12.pw,
                        Expanded(
                          child: CustomButtonWidget(
                            label: 'Reject',
                            onPressed: () => showRejectPickupDialog(
                              context,
                              onConfirm: () => AppRouter.back(),
                            ),
                            variant: CustomButtonVariant.secondary,
                            backgroundColor: const Color(0xffE85D3A),
                            height: 48,
                            expandWidth: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 12,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                ),
              ),
            ),
          
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
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
      child: Row(
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
                      style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ],
                ),
                4.ph,
                Text(
                  data.fullAddress,
                  style: context.robotoFlexRegular(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Material(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(Icons.phone, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: Icon(Icons.map_outlined, size: 48, color: Colors.grey.shade500),
          ),
          Center(
            child: Icon(Icons.location_on, size: 48, color: AppColors.primaryColor),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xff2F2F2F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${data.distanceKm}km away',
                style: context.robotoFlexMedium(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    IconData? icon,
    String? imagePath,
    required String title,
    required String value,
  }) {
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: imagePath != null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(imagePath, color: Colors.white),
                  )
                : Icon(icon, color: Colors.white, size: 24),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade700),
                ),
                4.ph,
                Text(
                  value,
                  style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
