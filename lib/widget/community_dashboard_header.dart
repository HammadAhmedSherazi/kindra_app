import 'dart:math' as math;

import '../export_all.dart';

/// Default [CommunityDashboardHeader.height] when the constructor default is used.
const double kDefaultCommunityDashboardHeaderHeight = 250;

/// Approximate Y (from screen top) just below [CommunityDashboardHeader] title copy,
/// so overlapping cards can sit in the green band without hiding text.
double communityDashboardHeaderTextSafeBottom(
  BuildContext context, {
  bool hasSubtitle = true,
  bool hasSectionTitle = true,
  bool hasHeaderCaption = false,
}) {
  final pad = MediaQuery.paddingOf(context).top;
  var y = pad + 8;
  y += 38;
  if (hasSubtitle) {
    y += 4 + 26;
  }
  if (hasSectionTitle) {
    y += hasSubtitle ? 8 : 12;
    y += 34;
  }
  if (hasHeaderCaption) {
    y += 6 + 20;
  }
  return y + 12;
}

/// Same idea for [CoastalGroupHeader] (logo + flow + section).
double coastalGroupHeaderTextSafeBottom(
  BuildContext context, {
  bool hasSectionTitle = true,
}) {
  final pad = MediaQuery.paddingOf(context).top;
  var y = pad + 8 + 34 + 4 + 22 + 8;
  if (hasSectionTitle) {
    y += 30;
  }
  return y + 12;
}

/// Household [HomeView] green strip (greeting block, not Kindra header widget).
double householdHomeBannerTextSafeBottom(BuildContext context) {
  final pad = MediaQuery.paddingOf(context).top;
  const bodyStartPadding = 80.0;
  const greetingBlock = 56.0;
  return math.max(bodyStartPadding + greetingBlock + 8, pad + 80);
}

/// [PointsView] compact green header (back + title row).
double pointsScreenHeaderTextSafeBottom(BuildContext context) {
  final pad = MediaQuery.paddingOf(context).top;
  return pad + 16 + 48 + 12;
}

/// Top offset for a [Stack] body that should **overlap** the green header stylishly,
/// but never start high enough to cover header text.
///
/// Uses `max(screenHeight * [screenHeightFraction], text-safe floor)`.
double communityDashboardStackContentTop(
  BuildContext context, {
  double screenHeightFraction = 0.22,
  double? minContentTop,
  bool hasSubtitle = true,
  bool hasSectionTitle = true,
  bool hasHeaderCaption = false,
  bool coastalHeaderLayout = false,
  bool coastalHasSectionTitle = true,
}) {
  final mediaHeight = MediaQuery.sizeOf(context).height;
  final ratioTop = mediaHeight * screenHeightFraction;
  final safe = minContentTop ??
      (coastalHeaderLayout
          ? coastalGroupHeaderTextSafeBottom(
              context,
              hasSectionTitle: coastalHasSectionTitle,
            )
          : communityDashboardHeaderTextSafeBottom(
              context,
              hasSubtitle: hasSubtitle,
              hasSectionTitle: hasSectionTitle,
              hasHeaderCaption: hasHeaderCaption,
            ));
  return math.max(ratioTop, safe);
}

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
    this.height = kDefaultCommunityDashboardHeaderHeight,
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
                    onTap: showNotificationIcon
                        ? (onNotificationTap ?? () {})
                        : onLogout,
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
