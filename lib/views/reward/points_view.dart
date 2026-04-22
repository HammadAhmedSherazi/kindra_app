import '../../export_all.dart';

class PointsView extends StatelessWidget {
  const PointsView({super.key});

  static const int _demoPoints = 85000;
  static const String _equivalentText = 'Equivalent to \$5';

  @override
  Widget build(BuildContext context) {
    final headerHeight = context.screenHeight * 0.27;
    const summaryCardEstimatedHeight = 220.0;
    final summaryCardTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: 0.14,
      minContentTop: pointsScreenHeaderTextSafeBottom(context),
    );
    final historySectionTopPadding =
        (summaryCardTop + summaryCardEstimatedHeight - headerHeight)
            .clamp(24.0, 280.0);

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Green header (home_view style)
              Container(
                height: headerHeight,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 16,
                  left: 20,
                  right: 20,
                  bottom: 24,
                ),

                decoration: const BoxDecoration(color: AppColors.primaryColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AppRouter.back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Color(0xffC2DDB9),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Points',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              historySectionTopPadding.ph,
              15.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Points Redemption History',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              16.ph,
              Expanded(
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = demoPointsRedemptionList[index];
                    return _RedemptionHistoryTile(item: item);
                  },
                  separatorBuilder: (context, index) => 16.ph,
                  itemCount: demoPointsRedemptionList.length,
                ),
              ),
            ],
          ),
          // Overlapping white card (home_view style positioned card)
          Positioned(
            top: summaryCardTop,
            left: 20,
            right: 20,
            child: _PointsSummaryCard(
              points: _demoPoints,
              equivalentText: _equivalentText,
            ),
          ),
        ],
      ),
    );
  }
}

class _PointsSummaryCard extends StatelessWidget {
  const _PointsSummaryCard({
    required this.points,
    required this.equivalentText,
  });

  final int points;
  final String equivalentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF7B7B7B)),
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          final iconSize = (cardWidth * 0.48).clamp(120.0, 200.0);
          final offset = (cardWidth * 0.05).clamp(12.0, 24.0);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -offset,
                top: -offset,
                child: Image.asset(
                  Assets.kindraColorCardIcon,
                  width: iconSize,
                ),
              ),
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    padding: EdgeInsets.all(13),
                    decoration: ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF5D5D5D),
                        ),
                      ),
                    ),
                    child: Image.asset(
                      Assets.amountDisplayIcon,
                      color: Color(0xff4D4D4D),
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Points',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.04,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w500,
                            height: 0.73,
                          ),
                        ),
                        15.ph,
                        Text(
                          points.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.38,
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
              20.ph,
              Row(
                children: [
                  Text(
                    'Equivalent to \$5',
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.70),
                      fontSize: 18.83,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w600,
                      height: 0.73,
                    ),
                  ),
                ],
              ),
              28.ph,
              _buildDottedDivider(),
              20.ph,
              SizedBox(
                width: double.infinity,
                child: CustomButtonWidget(
                  label: 'Redeem Points',
                  onPressed: () {
                    AppRouter.push(const RedeemMethodSelectionView());
                  },
                  textSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDottedDivider() {
    return Row(
      children: List.generate(
        40,
        (index) => Expanded(
          child: Container(
            height: 2,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            color: const Color(0xFF999999),
          ),
        ),
      ),
    );
  }
}

class _RedemptionHistoryTile extends StatelessWidget {
  const _RedemptionHistoryTile({required this.item});

  final PointsRedemptionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.transitionIcon, width: 55, height: 55),
        14.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                ),
              ),
              10.ph,
              Text(
                item.date,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Text(
          item.pointsDisplay,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
