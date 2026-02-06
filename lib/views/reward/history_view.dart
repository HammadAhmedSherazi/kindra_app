import '../../export_all.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<HistoryItem> _filterList(int index) {
    if (index == 0) return List.from(demoHistoryList);
    if (index == 1) {
      return demoHistoryList
          .where((e) => e.type == HistoryEntryType.garbage)
          .toList();
    }
    return demoHistoryList
        .where((e) => e.type == HistoryEntryType.points)
        .toList();
  }

  Map<String, List<HistoryItem>> _groupByDate(List<HistoryItem> items) {
    final map = <String, List<HistoryItem>>{};
    for (final item in items) {
      map.putIfAbsent(item.dateGroup, () => []).add(item);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        leading: IconButton(
          onPressed: () => AppRouter.back(),
          icon: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.only(left: 8),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(
                side: BorderSide(width: 1, color: Color(0xFFC9C9C9)),
              ),
            ),
            child: const Icon(Icons.arrow_back_ios, size: 18),
          ),
        ),
        centerTitle: true,
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(999),
              ),
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Garbage'),
                  Tab(text: 'Points'),
                ],
              ),
            ),
          ),
          20.ph,
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(3, (index) {
                final items = _filterList(index);
                final grouped = _groupByDate(items);
                final orderedDates = grouped.keys.toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: orderedDates.length,
                  itemBuilder: (context, i) {
                    final dateLabel = orderedDates[i];
                    final sectionItems = grouped[dateLabel]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateLabel,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        12.ph,
                        ...sectionItems.map(
                          (item) => _HistoryTile(
                            item: item,
                            onTap: () => AppRouter.push(
                              EcoPointsSuccessView(data: historyDetailFromItem(item)),
                              // HistoryDetailView(
                              //   data: historyDetailFromItem(item),
                              // ),
                            ),
                          ),
                        ),
                        20.ph,
                      ],
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.item, this.onTap});

  final HistoryItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isPoints = item.type == HistoryEntryType.points;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isPoints
              ? Container(
                  width: 55,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFECEFF4),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF7B7B7B),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.bookMarkIcon,
                      width: 22,
                      height: 22,
                    ),
                  ),
                )
              : SvgPicture.asset(Assets.transitionIcon, width: 55, height: 55),
          14.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 12,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              
                Text(
                  item.time,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Text(
            item.amountDisplay,
            style: TextStyle(
              color: item.isPositive
                  ? AppColors.primaryColor
                  : const Color(0xFFE53935),
              fontSize: 16,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        ),
      ),
    );
  }
}
