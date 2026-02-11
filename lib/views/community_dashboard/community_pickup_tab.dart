import '../../export_all.dart';

class CommunityPickupTab extends StatelessWidget {
  const CommunityPickupTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.23;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            sectionTitle: 'Pickups',
            onLogout: () {},
          ),
          Positioned(
            top: contentTop,
            left: horizontalPadding,
            right: horizontalPadding,
            child: Container(
              height: context.screenHeight * 0.78,
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNextPickupCard(context),
                    24.ph,
                    Text(
                      'Pickup History',
                      style: context.robotoFlexSemiBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    12.ph,
                    _buildHistoryItem(
                      context,
                      date: 'Monday, Apr 22',
                      time: '11:00 AM',
                      status: 'Completed',
                      isCompleted: true,
                    ),
                    10.ph,
                    _buildHistoryItem(
                      context,
                      date: 'Monday, Apr 22',
                      time: '11:00 AM',
                      status: 'Inprogress',
                      isCompleted: false,
                    ),
                    10.ph,
                    _buildHistoryItem(
                      context,
                      date: 'Monday, Apr 22',
                      time: '11:00 AM',
                      status: 'Completed',
                      isCompleted: true,
                    ),
                    24.ph,
                    CustomButtonWidget(
                      label: 'New Pickup',
                      onPressed: () =>
                          AppRouter.push(const PickupScheduleView()),
                    ),
                    24.ph,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextPickupCard(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Pickup',
                  style: context.robotoFlexSemiBold(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                12.ph,
                Text(
                  'Tuesday, May 12 | 10:00 AM - 12:00PM',
                  style: context.robotoFlexRegular(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                12.ph,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.checkedIcon,
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                      6.pw,
                      Text(
                        'Scheduled',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.pw,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 40,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context, {
    required String date,
    required String time,
    required String status,
    required bool isCompleted,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: context.robotoFlexSemiBold(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  time,
                  style: context.robotoFlexRegular(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.primaryColor
                  : Colors.red.shade400,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
