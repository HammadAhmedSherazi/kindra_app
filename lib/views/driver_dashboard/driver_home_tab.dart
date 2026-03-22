import '../../export_all.dart';

/// Driver Dashboard tab: stats cards, total earnings, pickup requests.
/// Follows same design pattern as Community/Business (green header, white cards).
class DriverHomeTab extends StatelessWidget {
  const DriverHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.22;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Driver',
            sectionTitle: 'Dashboard',
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
            child: Column(
              children: [
                _buildStatsGrid(context),
                        16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        
                        _buildEarningsCard(context),
                        20.ph,
                        _buildPickupRequestsSection(context),
                        24.ph,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.25,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 0
      ),
      children: [
        _buildStatCard(
          context,
          icon: Assets.trashCanIcon ,
          value: '15',
          label: "Today's Pickups",
        ),
        _buildStatCard(
          context,
          icon: Assets.environmentImpactIcon,
          value: '10',
          label: 'Pending Pickups',
        ),
        _buildStatCard(
          context,
          icon: Assets.environmentImpactIcon,
          value: '4,250',
          label: 'Completed Pickups',
        ),
        _buildStatCard(
          context,
          icon: Assets.dateIcon,
          value: 'Saturday',
          label: 'Total distance',
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String icon,
    required String value,
    required String label,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 32, color: AppColors.primaryColor),
          12.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          Image.asset(
            Assets.coinDollarIcon,
            height: 40,
            color: AppColors.primaryColor,
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Earnings',
                  style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                ),
                4.ph,
                Text(
                  '\$3,220',
                  style: context.robotoFlexBold(fontSize: 20, color: Colors.black.withValues(alpha: 0.66)),
                ),
              ],
            ),
          ),
          CustomButtonWidget(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            label: 'Withdraw',
            onPressed: () {
              AppRouter.push(
                const WithdrawFundsView(flowLabel: 'Driver'),
              );
            },
            variant: CustomButtonVariant.secondary,
            backgroundColor: const Color(0xff2F2F2F),
            height: 44,
            expandWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPickupRequestsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pickup Requests',
              style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'See All',
                style: context.robotoFlexMedium(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        12.ph,
        _buildPickupRequestCard(
          context,
          locationName: 'Mapco Gas station',
          address: 'Arcata East',
          timeSlot: '9:00 AM - 10:00 AM',
          quantity: '800 Liters',
          imageAsset: Assets.usedCookingOilCard,
        ),
        12.ph,
        _buildPickupRequestCard(
          context,
          locationName: 'Mapco Gas station',
          address: 'Arcata East',
          timeSlot: '9:00 AM - 10:00 AM',
          quantity: '800 Liters',
          imageAsset: Assets.usedCookingOilCard,
        ),
        12.ph,
        _buildPickupRequestCard(
          context,
          locationName: 'Mapco Gas station',
          address: 'Arcata East',
          timeSlot: '9:00 AM - 10:00 AM',
          quantity: '800 Liters',
          imageAsset: Assets.usedCookingOilCard,
        ),
      ],
    );
  }

  Widget _buildPickupRequestCard(
    BuildContext context, {
    required String locationName,
    required String address,
    required String timeSlot,
    required String quantity,
    required String imageAsset,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageAsset,
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
                      locationName,
                      style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                    ),
                    6.ph,
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600),
                        4.pw,
                        Text(
                          address,
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
                          timeSlot,
                          style: context.robotoFlexRegular(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                quantity,
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
                  onPressed: () {},
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
                  onPressed: () {},
                  variant: CustomButtonVariant.secondary,
                  backgroundColor: Colors.red.shade400,
                  height: 40,
                  expandWidth: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
