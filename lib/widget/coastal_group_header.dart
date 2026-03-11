import '../export_all.dart';

/// Green header for Coastal Group flow: Kindra logo, "Coastal Group", section title, notification.
class CoastalGroupHeader extends StatelessWidget {
  const CoastalGroupHeader({
    super.key,
    required this.sectionTitle,
    this.height = 200,
    this.onNotificationTap,
    this.leading,
    this.trailing,
  });

  final String sectionTitle;
  final double height;
  final VoidCallback? onNotificationTap;
  /// Optional leading widget (e.g. back button) for inner screens.
  final Widget? leading;
  /// Optional trailing widget (e.g. "Joined" pill) for inner screens.
  final Widget? trailing;

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
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.kindraTextWhiteLogo,
                      width: 140,
                    ),
                    4.ph,
                    Text(
                      'Coastal Group',
                      style: context.robotoFlexMedium(fontSize: 16, color: Colors.white70),
                    ),
                    8.ph,
                    Text(
                      sectionTitle,
                      style: context.robotoFlexBold(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
             trailing != null ? Column(
              spacing: 30,
              children: [
                GestureDetector(
                onTap: onNotificationTap ?? () {},
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        Assets.notificationIcon,
                        width: 22,
                        height: 22,
                      ),
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                trailing!,
              ],
             ) : GestureDetector(
                onTap: onNotificationTap ?? () {},
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        Assets.notificationIcon,
                        width: 22,
                        height: 22,
                      ),
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}
