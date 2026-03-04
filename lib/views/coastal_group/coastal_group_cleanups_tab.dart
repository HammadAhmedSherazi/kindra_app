import '../../export_all.dart';

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
    final contentTop = context.screenHeight * 0.22;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CoastalGroupHeader(
            sectionTitle: 'Upcoming Cleanups',
            height: context.screenHeight * 0.28,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey.shade600,
                      indicatorColor: AppColors.primaryColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: context.robotoFlexSemiBold(fontSize: 15),
                      tabs: const [
                        Tab(text: 'Upcoming'),
                        Tab(text: 'Past'),
                      ],
                    ),
                  ),
                ),
                16.ph,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _CleanupList(isUpcoming: true),
                      _CleanupList(isUpcoming: false),
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
  const _CleanupList({required this.isUpcoming});

  final bool isUpcoming;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      itemCount: 4,
      separatorBuilder: (_, _) => 12.ph,
      itemBuilder: (context, index) => _CleanupEventTile(
        title: 'Beach Cleanup in Arcata Bay',
        location: 'Arcata Bay, CA',
        members: '157',
        date: '20 Jun 2025',
        showJoinButton: isUpcoming,
      ),
    );
  }
}

class _CleanupEventTile extends StatelessWidget {
  const _CleanupEventTile({
    required this.title,
    required this.location,
    required this.members,
    required this.date,
    required this.showJoinButton,
  });

  final String title;
  final String location;
  final String members;
  final String date;
  final bool showJoinButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: Image.asset(
              Assets.placeholder,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Icon(Icons.image, color: Colors.grey.shade400),
            ),
          ),
          12.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
                ),
                4.ph,
                Text(
                  location,
                  style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                ),
                8.ph,
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 14, color: Colors.grey.shade600),
                    4.pw,
                    Text('$members Members', style: context.robotoFlexRegular(fontSize: 11, color: Colors.grey.shade600)),
                    16.pw,
                    Image.asset(Assets.timeIcon, width: 14, height: 14, color: Colors.grey.shade600),
                    4.pw,
                    Text(date, style: context.robotoFlexRegular(fontSize: 11, color: Colors.grey.shade600)),
                  ],
                ),
                if (showJoinButton) ...[
                  10.ph,
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: Text('Join Event', style: context.robotoFlexSemiBold(fontSize: 12, color: Colors.black87)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
