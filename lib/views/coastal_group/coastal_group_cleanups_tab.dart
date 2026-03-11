import '../../export_all.dart';

/// Cleanups tab: Upcoming / Past tabs, same body structure as Business Pickup tab.
class CoastalGroupCleanupsTab extends ConsumerStatefulWidget {
  const CoastalGroupCleanupsTab({super.key});

  @override
  ConsumerState<CoastalGroupCleanupsTab> createState() =>
      _CoastalGroupCleanupsTabState();
}

class _CoastalGroupCleanupsTabState extends ConsumerState<CoastalGroupCleanupsTab>
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
        children: [
          CoastalGroupHeader(
            sectionTitle: 'Upcoming Cleanups',
            height: context.screenHeight * 0.28,
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
                      Tab(text: 'Past'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _CleanupList(
                        isUpcoming: true,
                        horizontalPadding: horizontalPadding,
                      ),
                      _CleanupList(
                        isUpcoming: false,
                        horizontalPadding: horizontalPadding,
                      ),
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

class _CleanupList extends StatelessWidget {
  const _CleanupList({
    required this.isUpcoming,
    required this.horizontalPadding,
  });

  final bool isUpcoming;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final items = isUpcoming ? demoUpcomingCleanupEvents : demoPastCleanupEvents;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...items.map(
            (event) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CleanupEventCard(
                event: event,
                isUpcoming: isUpcoming,
                onTap: isUpcoming
                    ? () => AppRouter.push(JoinedEventDetailView(event: event))
                    : null,
                onActionPressed: isUpcoming
                    ? () => AppRouter.push(JoinedEventDetailView(event: event))
                    : null,
              ),
            ),
          ),
          // if (isUpcoming) ...[
          //   16.ph,
          //   CustomButtonWidget(
          //     label: 'Find Cleanup',
          //     onPressed: () {},
          //   ),
          // ],
          24.ph,
        ],
      ),
    );
  }
}
