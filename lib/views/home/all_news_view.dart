import '../../export_all.dart';

class AllNewsView extends ConsumerStatefulWidget {
  const AllNewsView({super.key});

  @override
  ConsumerState<AllNewsView> createState() => _AllNewsViewState();
}

class _AllNewsViewState extends ConsumerState<AllNewsView> {
  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(householdNewsProvider);
    final items = newsState.items;

    return CustomInnerScreenTemplate(
      title: 'News',
      child: ApiListHandler<NewsModel>(
        items: items,
        isLoadingInitial: newsState.isLoadingInitial,
        isLoadingMore: newsState.isLoadingMore,
        hasMore: newsState.hasMore,
        error: newsState.error,
        onRetry: () => ref.read(householdNewsProvider.notifier).fetchFirstPage(),
        onRefresh: () => ref.read(householdNewsProvider.notifier).refresh(),
        onLoadMore: () => ref.read(householdNewsProvider.notifier).fetchNextPage(),
        separator: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        empty: Center(
          child: Text(
            'No news yet',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.55),
              fontSize: 14,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        itemBuilder: (context, index, item) => NewsItemWidget(
          news: item,
          onTap: () => AppRouter.push(NewsDetailView(news: item)),
        ),
      ),
    );
  }
}