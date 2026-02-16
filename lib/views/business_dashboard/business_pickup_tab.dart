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
            onNotificationTap: () {},
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
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Completed',
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Rejected',
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Completed',
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Rejected',
      ),
      _PastPickupItem(
        date: 'Tuesday, April 16',
        quantity: '13.5 Liters',
        points: '50 Points',
        statusText: 'Completed',
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
  });
  final String date;
  final String quantity;
  final String points;
  final String statusText;
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
