import '../../export_all.dart';

/// Eco Tips & Education screen – shown when user taps "View Eco-tips" on business home.
/// Contains "This week's Eco Challenge" card and list of Eco Tips & Education items.
class EcoTipsEducationView extends StatelessWidget {
  const EcoTipsEducationView({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.23;

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
              sectionTitle: 'Eco Tips & Education',
              showZoneLabel: false,
              height: 250,
              showNotificationIcon: true,
              onLogout: () {},
              onNotificationTap: () => AppRouter.push(const NotificationView()),
            ),
            // Positioned(
            //   top: MediaQuery.paddingOf(context).top + 8,
            //   left: 8,
            //   child: GestureDetector(
            //     onTap: () => AppRouter.back(),
            //     child: Container(
            //       width: 40,
            //       height: 40,
            //       decoration: const BoxDecoration(
            //         color: Colors.white,
            //         shape: BoxShape.circle,
            //       ),
            //       child: const Icon(Icons.arrow_back_ios, size: 18),
            //     ),
            //   ),
            // ),
            Positioned(
              top: contentTop,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  _buildEcoChallengeCard(context),
                  16.ph,
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Eco - Tips & Education',
                            style: context.robotoFlexBold(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          16.ph,
                          ...demoNewsList.map(
                            (news) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _EcoTipListItem(
                                news: news,
                                onTap: () => AppRouter.push(
                                  EcoTipDetailView(
                                    title: news.title ?? 'Eco Tip',
                                    imageUrl: news.image,
                                    headline: 'Reduce waste, save energy',
                                    tips: _defaultPracticalTips,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          24.ph,
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

  Widget _buildEcoChallengeCard(BuildContext context) {
    const progress = 2;
    const total = 5;
    const challengeTitle = 'Track water usage for 1 week';
    const points = 50;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 25
      ),
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
          Text(
            "This week's Eco Challenge",
            style: context.robotoFlexBold(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          12.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Left ~2/3: image
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        width: w * 0.62,
                        child: Image.network(
                          'https://media.istockphoto.com/id/539201186/photo/cooking-oil.jpg?s=170667a&w=0&k=20&c=-9nMoAH1p-iAoAHJ_FVLVDIM93TXG4XNrieTRH-FNRE=',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported, size: 48),
                          ),
                        ),
                      ),
                      // Gradient blend: transparent -> green (right side)
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.transparent,
                                AppColors.primaryColor.withValues(alpha: 0.4),
                                AppColors.primaryColor,
                              ],
                              stops: const [0.5, 0.7, 0.88],
                            ),
                          ),
                        ),
                      ),
                      // Right: solid green area (so text is readable)
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        width: w * 0.42,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      // Content on right (on green)
                      Positioned(
                        right: 16,
                        top: 16,
                        bottom: 16,
                        left: w * 0.38,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              challengeTitle,
                              style: context.robotoFlexSemiBold(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            12.ph,
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progress / total,
                                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                      minHeight: 8,
                                    ),
                                  ),
                                ),
                                8.pw,
                                Text(
                                  '$progress/$total',
                                  style: context.robotoFlexSemiBold(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            12.ph,
                            Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () => AppRouter.push(
                                      EcoTipDetailView(
                                        title: 'Greener Kitchen Practices',
                                        headline: 'Reduce waste, save energy',
                                        tips: _defaultPracticalTips,
                                        showSubmitButtons: true,
                                        onSubmitted: () {
                                          AppRouter.back();
                                          AppRouter.push(const EcoChallengeCompletedView());
                                        },
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      'Track Progress',
                                      style: context.robotoFlexSemiBold(fontSize: 14),
                                    ),
                                  ),
                                ),
                                12.pw,
                                Text(
                                  '+${points}Points',
                                  style: context.robotoFlexSemiBold(
                                    fontSize: 14,
                                    color: Colors.white,
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

  static const List<({String title, String description})> _defaultPracticalTips = [
    (title: '1. Use Energy-Efficient Equipment', description: 'Upgrade to energy-saving appliances like induction cooktops and LED lighting'),
    (title: '2. Reduce Food Waste', description: 'Reduce waste by properly storing food and repurposing scraps where possible.'),
    (title: '3. Recycle Cooking Oil', description: 'Collect used cooking oil and use Kindra pickup for responsible recycling.'),
  ];
}

class _EcoTipListItem extends StatelessWidget {
  const _EcoTipListItem({
    required this.news,
    required this.onTap,
  });

  final NewsModel news;
  final VoidCallback onTap;

  static const List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day} ${_monthNames[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = news.image ??
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8kvhwsPdeSIGSEvbktsxc_4pQpEqu4ykg4A&s';
    final title = news.title ?? '';
    final description = news.description ?? '';
    final dateStr = _formatDate(news.date);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: SizedBox(
        height: 114,
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(
                imageUrl,
                height: double.infinity,
                width: 114,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: double.infinity,
                  width: 114,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  1.ph,
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.robotoFlexSemiBold(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.robotoFlexRegular(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.grey.shade600,
                            size: 18,
                          ),
                          Text(
                            dateStr,
                            style: context.robotoFlexRegular(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Watch video',
                        style: context.robotoFlexSemiBold(
                          fontSize: 13,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
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
