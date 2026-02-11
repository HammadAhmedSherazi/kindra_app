import '../export_all.dart';

/// Generic header for community dashboard screens.
/// Use [subtitle] for the small label (e.g. "Community Dashboard"),
/// [sectionTitle] for the main heading when needed,
/// [zoneLabel] for the badge (e.g. "Green Zone"), and [onLogout] for logout.
class CommunityDashboardHeader extends StatelessWidget {
  const CommunityDashboardHeader({
    super.key,
    this.subtitle = 'Community Dashboard',
    this.sectionTitle = '',
    this.zoneLabel = 'Green Zone',
    this.height = 250,
    this.showZoneLabel = true,
    this.logoutTextColor,
    required this.onLogout,
  });

  final String subtitle;
  final String sectionTitle;
  final String zoneLabel;
  final double height;
  final bool showZoneLabel;
  final Color? logoutTextColor;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 8,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.kindraTextWhiteLogo,
                      width: 160,
                    ),
                    4.ph,
                    Text(
                      subtitle,
                      style: context.robotoFlexMedium(fontSize: 20, color: Colors.white),
                    ),
                    if (sectionTitle.isNotEmpty) ...[
                      8.ph,
                      Text(
                        sectionTitle,
                        style: context.robotoFlexSemiBold(fontSize: 28, color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: onLogout,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        Assets.homeLogoutIcon,
                        width: 24,
                        height: 24,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  4.ph,
                  Text(
                    'Logout',
                    style: context.robotoFlexSemiBold(
                      fontSize: 12,
                      color: logoutTextColor ?? Colors.white,
                    ),
                  ),
                  if (showZoneLabel) ...[
                    20.ph,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Text(
                        zoneLabel,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
