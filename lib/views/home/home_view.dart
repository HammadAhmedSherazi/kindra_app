import '../../export_all.dart';

/// Points card: show a short prefix only; rest masked with asterisks.
String _maskedPointsCardName(String? displayName) {
  final s = displayName?.trim();
  if (s == null || s.isEmpty) return '****';
  if (s.length <= 3) {
    return '${s.substring(0, 1)}****';
  }
  return '${s.substring(0, 3)}*******';
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final headerHeight = context.screenHeight * 0.33;
    final pointsCardHeight =
        (context.screenHeight * 0.27).clamp(200.0, 280.0);
    final pointsCardTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: 0.20,
      minContentTop: householdHomeBannerTextSafeBottom(context),
    );
    final listTopInset =
        (pointsCardTop + pointsCardHeight - headerHeight).clamp(24.0, 400.0);

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  height: headerHeight,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),

                  decoration: BoxDecoration(color: AppColors.primaryColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer(
                              builder: (context, ref, _) {
                                final displayName = ref.watch(
                                  currentUserBaseProvider.select((async) {
                                    final fromFirestore = async.maybeWhen(
                                      data: (p) =>
                                          (p?.displayName.isNotEmpty == true)
                                              ? p!.displayName
                                              : null,
                                      orElse: () => null,
                                    );
                                    if (fromFirestore != null &&
                                        fromFirestore.trim().isNotEmpty) {
                                      return fromFirestore;
                                    }
                                    final authName = FirebaseAuthService
                                        .instance.currentUserDisplayName;
                                    return (authName != null &&
                                            authName.trim().isNotEmpty)
                                        ? authName
                                        : null;
                                  }),
                                );

                                return Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w500,
                                      height: 1.65,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Hello '),
                                      WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.middle,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Transform.flip(
                                            flipX: true,
                                            child: Image.asset(
                                              Assets.helloHandIcon,
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n${displayName ?? 'User'}',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => AppRouter.push(const NotificationView()),
                        child: Container(
                          width: 45,
                          height: 45,
                          padding: EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                          child: Image.asset(Assets.notificationIcon),
                        ),
                      ),
                    ],
                  ),
                ),
                10.ph,
                Expanded(
                  child: ListView(
                    // shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      listTopInset.ph,
                      Text(
                        'Services Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      10.ph,
                      Container(
                        width: 371,
                        // height: 77,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFECEFF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        child: ListTile(
                          onTap: () => AppRouter.push(const PointsView()),
                          leading: Container(
                            width: 55,
                            height: 55,
                            padding: EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF4C9A31),
                              shape: OvalBorder(),
                            ),
                            child: Image.asset(Assets.addLocationIcon),
                          ),
                          title: Text(
                            'Used Oil Collection Point.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Earn your points',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Roboto Flex',
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                      40.ph,
                      Consumer(
                        builder: (context, ref, _) {
                          final newsState = ref.watch(householdNewsProvider);
                          final items = newsState.items;

                          final showCount = 3; // Home pe sirf itne items
                          final shouldShowSeeAll =
                              items.length > showCount || newsState.hasMore;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'News',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Roboto Flex',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (shouldShowSeeAll)
                                    TextButton(
                                      onPressed: () {
                                        AppRouter.push(const AllNewsView());
                                      },
                                      child: Text(
                                        'See All',
                                        style: TextStyle(
                                          color: Colors.black
                                              .withValues(alpha: 0.40),
                                          fontSize: 15,
                                          fontFamily: 'Roboto Flex',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Consumer(
                        builder: (context, ref, _) {
                          final newsState = ref.watch(householdNewsProvider);
                          final items = newsState.items;
                          final showCount = 3;
                          final showItems = items.length > showCount
                              ? items.sublist(0, showCount)
                              : items;

                          return ApiListHandler<NewsModel>(
                            items: showItems,
                            isLoadingInitial: newsState.isLoadingInitial,
                            isLoadingMore: false,
                            hasMore: false,
                            error: newsState.error,
                            onRetry: () => ref
                                .read(householdNewsProvider.notifier)
                                .fetchFirstPage(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separator: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(),
                            ),
                            empty: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No news yet',
                                    style: TextStyle(
                                      color:
                                          Colors.black.withValues(alpha: 0.55),
                                      fontSize: 14,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            skeletonCount: 3,
                            skeletonItem: NewsItemWidget(
                              news: NewsModel(
                                image:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8kvhwsPdeSIGSEvbktsxc_4pQpEqu4ykg4A&s',
                                title: 'Loading title',
                                description:
                                    'Loading description for the news item...',
                                date: DateTime.now(),
                              ),
                              onTap: () {},
                            ),
                            itemBuilder: (context, index, item) => NewsItemWidget(
                              news: item,
                              onTap: () => AppRouter.push(
                                NewsDetailView(news: item),
                              ),
                            ),
                          );
                        },
                      ),
                      (context.screenHeight * 0.22).clamp(120.0, 220.0).ph,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: pointsCardTop,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              height: pointsCardHeight,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(23),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = constraints.maxWidth;
                  final iconSize = (cardWidth * 0.48).clamp(120.0, 200.0);
                  final offset = (cardWidth * 0.01).clamp(2.0, 6.0);
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -offset,
                        top: -offset,
                        child: Image.asset(
                          Assets.kindraCardIcon,
                          width: iconSize,
                        ),
                      ),
                      Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              padding: EdgeInsets.all(14),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF4C4C4C),
                                shape: OvalBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Image.asset(Assets.amountDisplayIcon),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Points',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.04,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w500,
                                      height: 0.73,
                                    ),
                                  ),
                                  Text(
                                    '85000',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23.38,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w500,
                                      height: 0.73,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Consumer(
                                builder: (context, ref, _) {
                                  final displayName = ref.watch(
                                    currentUserBaseProvider.select((async) {
                                      final fromFirestore = async.maybeWhen(
                                        data: (p) =>
                                            (p?.displayName.isNotEmpty == true)
                                                ? p!.displayName
                                                : null,
                                        orElse: () => null,
                                      );
                                      if (fromFirestore != null &&
                                          fromFirestore.trim().isNotEmpty) {
                                        return fromFirestore;
                                      }
                                      final authName = FirebaseAuthService
                                          .instance.currentUserDisplayName;
                                      return (authName != null &&
                                              authName.trim().isNotEmpty)
                                          ? authName
                                          : null;
                                    }),
                                  );
                                  return Text(
                                    _maskedPointsCardName(displayName),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.83,
                                      fontFamily: 'Roboto Flex',
                                      fontWeight: FontWeight.w600,
                                      height: 0.73,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 24,
                          children: [
                            Expanded(
                              child: CustomButtonWidget(
                                label: "Redeem Point",
                                onPressed: () {},
                                textSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: CustomButtonWidget(
                                label: 'History',
                                onPressed: () {
                                  AppRouter.push(const HistoryView());
                                },
                                backgroundColor: Colors.white.withValues(alpha: 0.35),
                                borderColor: Colors.white,
                                textColor: Colors.white,
                                variant: CustomButtonVariant.outlined,
                                textSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                    ],
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
