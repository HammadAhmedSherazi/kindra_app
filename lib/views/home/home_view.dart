import '../../export_all.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final profileAsync = ref.watch(currentUserProfileProvider);
    final authName = FirebaseAuthService.instance.currentUserDisplayName;
    final displayName = profileAsync.maybeWhen(
          data: (p) =>
              (p?.displayName.isNotEmpty == true) ? p!.displayName : null,
          orElse: () => null,
        ) ??
        (authName != null && authName.trim().isNotEmpty ? authName : null);

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
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontFamily: 'Roboto Flex',
                                  fontWeight: FontWeight.w500,
                                  height: 1.65,
                                ),
                                children: [
                                  TextSpan(text: 'Hello '),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4),
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
                                  TextSpan(text: '\n${displayName ?? 'User'}'),
                                ],
                              ),
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
                      17.ph,
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
                      Row(
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
                          TextButton(
                            onPressed: () {
                              AppRouter.push(AllNewsView());
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.40),
                                fontSize: 15,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: demoNewsList.length,
                        itemBuilder: (context, index) => NewsItemWidget(
                          news: demoNewsList[index],
                          onTap: () => AppRouter.push(
                            NewsDetailView(news: demoNewsList[index]),
                          ),
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(),
                        ),
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
                              child: Text(
                                'Faj*******',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.83,
                                  fontFamily: 'Roboto Flex',
                                  fontWeight: FontWeight.w600,
                                  height: 0.73,
                                ),
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
