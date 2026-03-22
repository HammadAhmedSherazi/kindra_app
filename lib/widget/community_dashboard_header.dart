import '../export_all.dart';

/// Generic header for community dashboard screens.
/// Use [subtitle] for the small label (e.g. "Community Dashboard"),
/// [sectionTitle] for the main heading when needed,
/// [zoneLabel] for the badge (e.g. "Green Zone"), and [onLogout] for logout.
/// Set [showNotificationIcon] true (e.g. business flow) to show notification icon instead of logout.
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
    this.showNotificationIcon = false,
    this.onNotificationTap,
    this.backgroundColor,
    this.logoAsset,
    this.subtitleColor,
    this.sectionTitleColor,
    this.headerCaption,
    this.headerCaptionColor,
    this.sideActionLabelColor,
    this.showSideActionLabel = true,
  });

  final String subtitle;
  final String sectionTitle;
  final String zoneLabel;
  final double height;
  final bool showZoneLabel;
  final Color? logoutTextColor;
  final VoidCallback onLogout;
  final bool showNotificationIcon;
  final VoidCallback? onNotificationTap;
  /// When set (e.g. report-issue cream header), overrides primary green.
  final Color? backgroundColor;
  /// Defaults to [Assets.kindraTextWhiteLogo] on green headers; use [Assets.kindraTextLogo] on light headers.
  final String? logoAsset;
  final Color? subtitleColor;
  final Color? sectionTitleColor;
  final String? headerCaption;
  final Color? headerCaptionColor;
  final Color? sideActionLabelColor;
  /// When false, hides the "Notifications" / "Logout" caption under the side icon.
  final bool showSideActionLabel;

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
      decoration: BoxDecoration(color: backgroundColor ?? AppColors.primaryColor),
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
                      logoAsset ?? Assets.kindraTextWhiteLogo,
                      width: 160,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      4.ph,
                      Text(
                        subtitle,
                        style: context.robotoFlexMedium(
                          fontSize: 20,
                          color: subtitleColor ?? Colors.white,
                        ),
                      ),
                    ],
                    if (sectionTitle.isNotEmpty) ...[
                      if (subtitle.isNotEmpty) 8.ph else 12.ph,
                      Text(
                        sectionTitle,
                        style: context.robotoFlexSemiBold(
                          fontSize: 28,
                          color: sectionTitleColor ?? Colors.white,
                        ),
                      ),
                    ],
                    if (headerCaption != null && headerCaption!.isNotEmpty) ...[
                      6.ph,
                      Text(
                        headerCaption!,
                        style: context.robotoFlexRegular(
                          fontSize: 16,
                          color: headerCaptionColor ?? Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: showNotificationIcon ? (onNotificationTap ?? () {}) : (){
                      AppRouter.pushAndRemoveUntil(LoginView());
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        showNotificationIcon ? Assets.notificationIcon : Assets.homeLogoutIcon,
                        width: 24,
                        height: 24,
                        color: showNotificationIcon ? null : AppColors.primaryColor,
                      ),
                    ),
                  ),
                  if (showSideActionLabel) ...[
                    4.ph,
                    Text(
                      showNotificationIcon ? 'Notifications' : 'Logout',
                      style: context.robotoFlexSemiBold(
                        fontSize: 12,
                        color:
                            sideActionLabelColor ?? logoutTextColor ?? Colors.white,
                      ),
                    ),
                  ],
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
