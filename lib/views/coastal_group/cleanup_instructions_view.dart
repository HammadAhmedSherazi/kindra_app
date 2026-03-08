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
    final contentTop = context.screenHeight * 0.24;

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
              height: context.screenHeight * 0.30,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              leading: GestureDetector(
                onTap: () => AppRouter.back(),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
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
                      'Sunday, April 28',
                      style: context.robotoFlexRegular(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey.shade600,
              ),
            ],
          ),
          20.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              Assets.oceanGuardiansImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          20.ph,
          Center(
            child: Text(
              'Instructions',
              style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
            ),
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
