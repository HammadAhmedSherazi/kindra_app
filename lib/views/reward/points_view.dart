import '../../export_all.dart';

class PointsView extends StatelessWidget {
  const PointsView({super.key});

  static const int _demoPoints = 85000;
  static const String _equivalentText = 'Equivalent to \$5';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Green header (home_view style)
              Container(
                height: context.screenHeight * 0.27,
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
              130.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Ponts Redemption History',
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
            top: context.screenHeight * 0.14,
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Subtle pattern (right & bottom)
          // Positioned(
          //   right: -20,
          //   bottom: -20,
          //   child: Opacity(
          //     opacity: 0.06,
          //     child: CustomPaint(
          //       size: Size(120, 120),
          //       painter: _SwirlPatternPainter(),
          //     ),
          //   ),
          // ),
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
                  const KindraLogoWithRingsWidget(
                    logoWidth: 72,
                    logoHeight: 28,
                    width: 100,
                    height: 56,
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
              20.ph,
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

class _SwirlPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (var i = 0; i < 8; i++) {
      final path = Path();
      path.moveTo(size.width * (0.2 + i * 0.08), size.height * 0.5);
      path.quadraticBezierTo(
        size.width * (0.5 + i * 0.05),
        size.height * (0.3 - i * 0.02),
        size.width * 0.8,
        size.height * (0.4 + i * 0.05),
      );
      path.quadraticBezierTo(
        size.width * (0.6 - i * 0.03),
        size.height * 0.7,
        size.width * 0.2,
        size.height * 0.6,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
