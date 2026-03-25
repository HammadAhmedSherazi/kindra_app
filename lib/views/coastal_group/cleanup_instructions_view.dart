import '../../export_all.dart';

/// Cleanup instructions screen: date, image, bullet list, Back to Event.
class CleanupInstructionsView extends StatelessWidget {
  const CleanupInstructionsView({
    super.key,
    required this.event,
  });

  final CleanupEventItem event;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final headerHeight = context.screenHeight * 0.30;
    final contentTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: 0.24,
      coastalHeaderLayout: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CoastalGroupHeader(
              sectionTitle: 'Cleanup Instructions',
              height: headerHeight,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              // leading: GestureDetector(
              //   onTap: () => AppRouter.back(),
              //   child: const Padding(
              //     padding: EdgeInsets.only(top: 4),
              //     child: Icon(
              //       Icons.arrow_back_ios,
              //       color: Colors.white,
              //       size: 22,
              //     ),
              //   ),
              // ),
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildContentCard(context),
                    24.ph,
                    CustomButtonWidget(
                      label: 'Back to Event',
                      onPressed: () => AppRouter.back(),
                      backgroundColor: const Color(0xff414141),
                      height: 52,
                    ),
                    100.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    const imageHeight = 280.0;
    const topGradientHeight = 180.0;
    const bottomGradientHeight = 80.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  Assets.oceanGuardiansImage,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: topGradientHeight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withValues(alpha: 0.8),
                        Colors.white.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: bottomGradientHeight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => AppRouter.back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.only(left: 8),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFC9C9C9),
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back_ios, size: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cleanup Instructions',
                            style: context.robotoFlexBold(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Sunday, April 28 >',
                            textAlign: TextAlign.center,
                            style: context.robotoFlexRegular(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Instructions',
                      textAlign: TextAlign.center,
                      style: context.robotoFlexBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                12.ph,
                _bullet(
                  context,
                  'Meet at 10:00 AM with our Ocean Guardians group by the lifeguard station',
                ),
                8.ph,
                _bullet(
                  context,
                  'Sign in and grab your gear (vests, gloves, and bags provided)',
                ),
                8.ph,
                _bullet(
                  context,
                  'Listen to the safety briefing and cleanup tips',
                ),
                8.ph,
                _bullet(
                  context,
                  'Pair up and start cleaning the beach, focusing on plastic debris and hazardous waste like fishing nets and sharp objects. Please report any large, heavy, or dangerous items to the leader.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              shape: BoxShape.circle,
            ),
          ),
        ),
        10.pw,
        Expanded(
          child: Text(
            text,
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
