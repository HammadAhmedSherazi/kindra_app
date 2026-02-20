import '../../export_all.dart';

/// Detail screen for an eco tip (e.g. Greener Kitchen Practices).
/// Shows video area, headline, practical tips, and Submit / Back buttons when [showSubmitButtons] is true.
class EcoTipDetailView extends StatelessWidget {
  const EcoTipDetailView({
    super.key,
    required this.title,
    required this.headline,
    required this.tips,
    this.imageUrl,
    this.showSubmitButtons = false,
    this.onSubmitted,
  });

  final String title;
  final String headline;
  final String? imageUrl;
  final List<({String title, String description})> tips;
  final bool showSubmitButtons;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.22;
    final defaultImage =
        'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800';

    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CommunityDashboardHeader(
              subtitle: 'Business Dashboard',
              sectionTitle: title,
              showZoneLabel: false,
              showNotificationIcon: true,
              onLogout: () {},
              onNotificationTap: () => AppRouter.push(const NotificationView()),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 8,
              left: 8,
              child: GestureDetector(
                onTap: () => AppRouter.back(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios, size: 18),
                ),
              ),
            ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            imageUrl ?? defaultImage,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 48,
                              ),
                            ),
                          ),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  16.ph,
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            headline,
                            style: context.robotoFlexBold(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          20.ph,
                          Text(
                            'Practical Tips',
                            style: context.robotoFlexBold(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          16.ph,
                          ...tips.map(
                            (tip) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
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
                                    Text(
                                      tip.title,
                                      style: context.robotoFlexSemiBold(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    8.ph,
                                    Text(
                                      tip.description,
                                      style: context.robotoFlexRegular(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (showSubmitButtons) ...[
                            24.ph,
                            CustomButtonWidget(
                              label: 'Submit',
                              onPressed: onSubmitted ?? () => AppRouter.back(),
                            ),
                            12.ph,
                            CustomButtonWidget(
                              label: 'Back',
                              variant: CustomButtonVariant.outlined,
                              onPressed: () => AppRouter.back(),
                              backgroundColor: Colors.grey.shade300,
                              borderColor: Colors.grey.shade400,
                              textColor: Colors.black87,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
