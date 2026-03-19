import '../../../export_all.dart';

class DriverFlowBottomNavBar extends StatelessWidget {
  const DriverFlowBottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap:
                    () => AppRouter.pushAndRemoveUntil(
                      const DriverDashboardView(initialIndex: 0),
                    ),
              ),
              _NavItem(
                icon: Assets.requestsIcon,
                label: 'Requests',
                isSelected: currentIndex == 1,
                onTap:
                    () => AppRouter.pushAndRemoveUntil(
                      const DriverDashboardView(initialIndex: 1),
                    ),
              ),
              _NavItem(
                icon: Assets.earningIcon,
                label: 'Earning',
                isSelected: currentIndex == 2,
                onTap:
                    () => AppRouter.pushAndRemoveUntil(
                      const DriverDashboardView(initialIndex: 2),
                    ),
              ),
              _NavItem(
                icon: Assets.impactIcon,
                label: 'Impact',
                isSelected: currentIndex == 3,
                onTap:
                    () => AppRouter.pushAndRemoveUntil(
                      const DriverDashboardView(initialIndex: 3),
                    ),
              ),
              _NavItem(
                icon: Assets.navUserIcon,
                label: 'Profile',
                isSelected: currentIndex == 4,
                onTap:
                    () => AppRouter.pushAndRemoveUntil(
                      const DriverDashboardView(initialIndex: 4),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentProcessingCard extends StatelessWidget {
  const PaymentProcessingCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 6,
                ),
              ),
            ),
          ),
          18.ph,
          Text(
            title,
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SuccessBubblesCheckGraphic extends StatelessWidget {
  const SuccessBubblesCheckGraphic({super.key, this.small = false});

  final bool small;

  @override
  Widget build(BuildContext context) {
    final outerSize = small ? 120.0 : 140.0;
    return SizedBox(
 
      height: outerSize,
     
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 8,
            left: 60,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.18), 10),
          ),
          Positioned(
            top: 62,
            right: 68,
            child: _decoCircle(Colors.grey.shade300, 14),
          ),
          Positioned(
            bottom: 30,
            left: 52,
            child: _decoCircle(Colors.grey.shade200, 18),
          ),
          Positioned(
            top: 1,
            right: 50,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.18), 40),
          ),
          Container(
            width: outerSize,
            height: outerSize,
            decoration: const BoxDecoration(
              color: Color(0xffD3FFC4),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(small ? 18 : 32),
            child: FittedBox(
              fit: BoxFit.contain,
              child: SvgPicture.asset(
                Assets.driverPickupSuccessIcon,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decoCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// Warning triangle with decorative bubbles (report issue success / cancel).
class ReportIssueWarningGraphic extends StatelessWidget {
  const ReportIssueWarningGraphic({super.key, this.small = false});

  static const Color _iconCircleBg = Color(0xFFFFE8BE);

  final bool small;

  @override
  Widget build(BuildContext context) {
    final outerSize = small ? 120.0 : 140.0;
    return SizedBox(
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 8,
            left: 60,
            child: _decoCircle(const Color(0xFFE0A02F).withValues(alpha: 0.25), 10),
          ),
          Positioned(
            top: 62,
            right: 68,
            child: _decoCircle(Colors.grey.shade300, 14),
          ),
          Positioned(
            bottom: 30,
            left: 52,
            child: _decoCircle(Colors.grey.shade200, 18),
          ),
          Positioned(
            top: 1,
            right: 50,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.15), 40),
          ),
          Container(
            width: outerSize,
            height: outerSize,
            decoration: const BoxDecoration(
              color: _iconCircleBg,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(small ? 22 : 36),
            child: SvgPicture.asset(
              Assets.reportIssueWarningIcon,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _decoCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class ArrivalGraphic extends StatelessWidget {
  const ArrivalGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = context.screenWidth;
    final size = (sw * 0.32).clamp(120, 170).toDouble();
    return SizedBox(
      width: sw - 50,
      height: size + 58,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              
                          Text(
                            'Arrival Confirmed',
                            style: context.robotoFlexBold(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          8.ph,
                          Text(
                            'You have arrived at the pickup location',
                            style: context.robotoFlexRegular(
                              fontSize: 18,
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
            ],
          ),
          Positioned(
            top: 8,
            left: 30,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.15), 14),
          ),
          Positioned(
            top: 2,
            right: 30,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.15), 46),
          ),
          Positioned(
            top: 58,
            right: 88,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.15), 18),
          ),
          Positioned(
            bottom: 52,
            left: 80,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.15), 16),
          ),
          Positioned(
            bottom: 68,
            right: 52,
            child: _decoCircle(AppColors.primaryColor.withValues(alpha: 0.15), 20),
          ),
          
          Positioned(
            top: 80,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: size * 0.76),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decoCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class RouteMapPlaceholder extends StatelessWidget {
  const RouteMapPlaceholder({super.key, required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: 270,
            width: constraints.maxWidth,
            child: Image.network('https://i.sstatic.net/Ye35B.png', fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

class PickupLocationCard extends StatelessWidget {
  const PickupLocationCard({super.key, required this.data});

  final DriverPickupRequestData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(data.imageAsset, width: 72, height: 72, fit: BoxFit.cover),
          ),
          12.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.locationName,
                  style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
                ),
                6.ph,
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    4.pw,
                    Expanded(
                      child: Text(
                        data.areaName,
                        style: context.robotoFlexRegular(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                4.ph,
                Text(
                  data.fullAddress,
                  style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LabelValueRow extends StatelessWidget {
  const LabelValueRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.robotoFlexRegular(fontSize: 14, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: context.robotoFlexSemiBold(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primaryColor : Colors.black.withValues(alpha: 0.5);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 28, height: 28, color: color),
            6.ph,
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
            6.ph,
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
