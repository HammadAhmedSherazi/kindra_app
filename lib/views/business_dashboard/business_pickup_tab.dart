import '../../export_all.dart';

/// Pickup tab for business dashboard: Upcoming / Past Pickup tabs, list, Request Pickup.
class BusinessPickupTab extends StatefulWidget {
  const BusinessPickupTab({super.key});

  @override
  State<BusinessPickupTab> createState() => _BusinessPickupTabState();
}

class _BusinessPickupTabState extends State<BusinessPickupTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        // clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            subtitle: 'Business Dashboard',
            sectionTitle: 'Pickup',
            onLogout: () {},
            showNotificationIcon: true,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.grey.shade500,
                    indicatorColor: AppColors.primaryColor,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.grey.shade500,
                    labelStyle: context.robotoFlexSemiBold(fontSize: 15),
                    unselectedLabelStyle: context.robotoFlexRegular(fontSize: 15),
                    tabs: const [
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Past Pickup'),
                    ],
                  ),
                ),
                // Container(
                //   height: 1,
                //   color: Colors.grey.shade500,
                // ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _UpcomingPickupList(horizontalPadding: horizontalPadding),
                      _PastPickupList(horizontalPadding: horizontalPadding),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingPickupList extends StatelessWidget {
  const _UpcomingPickupList({required this.horizontalPadding});

  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final upcomingItems = [
      _PickupItem(
        date: 'Tuesday, April 16',
        timeRange: 'Between 9:00 AM - 12:00 PM',
        statusText: 'Scheduled. No Driver Assigned Yet',
      ),
      _PickupItem(
        date: 'Tuesday, April 16',
        timeRange: 'Between 9:00 AM - 12:00 PM',
        statusText: 'Scheduled. No Driver Assigned Yet',
      ),
      _PickupItem(
        date: 'Tuesday, April 16',
        timeRange: 'Between 9:00 AM - 12:00 PM',
        statusText: 'Scheduled. No Driver Assigned Yet',
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...upcomingItems.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PickupScheduleCard(
                date: e.date,
                timeRange: e.timeRange,
                statusText: e.statusText,
              ),
            ),
          ),
          16.ph,
          CustomButtonWidget(
            label: 'Request Pickup',
            onPressed: () => AppRouter.push(const BusinessPickupScheduleView()),
          ),
          24.ph,
        ],
      ),
    );
  }
}

class _PastPickupList extends StatelessWidget {
  const _PastPickupList({required this.horizontalPadding});

  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final pastItems = [
      _PastPickupItem(
        date: 'Wednesday, July 3, 2025',
        quantity: '560 Liters',
        points: '50 Points',
        statusText: 'Completed',
        pickupId: '#5125698',
        redemptionId: '0 123 456 ****',
        typeOfWeight: 'Non-organic waste',
        pointsEarned: 280,
        totalPoints: 200,
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Rejected',
        pickupId: '#5125697',
        redemptionId: '0 123 456 ****',
        typeOfWeight: 'Non-organic waste',
        totalPoints: 200,
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Completed',
        pickupId: '#5125696',
        redemptionId: '0 123 456 ****',
        typeOfWeight: 'Non-organic waste',
        pointsEarned: 50,
        totalPoints: 200,
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Rejected',
        pickupId: '#5125695',
        redemptionId: '0 123 456 ****',
        typeOfWeight: 'Non-organic waste',
        totalPoints: 200,
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Completed',
        pickupId: '#5125694',
        redemptionId: '0 123 456 ****',
        typeOfWeight: 'Non-organic waste',
        pointsEarned: 50,
        totalPoints: 200,
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...pastItems.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PickupScheduleCard(
                date: e.date,
                statusText: e.statusText,
                quantity: e.quantity,
                points: e.points,
                onTap: () {
                  final detailData = PastPickupDetailData(
                    pickupId: e.pickupId,
                    redemptionId: e.redemptionId,
                    typeOfWeight: e.typeOfWeight,
                    wasteQuantity: e.quantity,
                    date: e.date,
                    pointsEarned: e.pointsEarned,
                    totalPoints: e.totalPoints,
                  );
                  AppRouter.push(
                    PastPickupDetailView(
                      data: detailData,
                      isCompleted: e.statusText == 'Completed',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PastPickupItem {
  _PastPickupItem({
    required this.date,
    required this.quantity,
    required this.points,
    required this.statusText,
    this.pickupId = '#5125698',
    this.redemptionId = '0 123 456 ****',
    this.typeOfWeight = 'Non-organic waste',
    this.pointsEarned,
    this.totalPoints = 200,
  });
  final String date;
  final String quantity;
  final String points;
  final String statusText;
  final String pickupId;
  final String redemptionId;
  final String typeOfWeight;
  final int? pointsEarned;
  final int totalPoints;
}

class _PickupItem {
  _PickupItem({
    required this.date,
    required this.timeRange,
    required this.statusText,
  });
  final String date;
  final String timeRange;
  final String statusText;
}
