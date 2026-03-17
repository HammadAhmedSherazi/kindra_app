import '../../export_all.dart';

/// Driver flow dashboard. Tabs: Home, Requests, Earning, Impact, Profile.
/// Follows same design pattern as Community/Business dashboard (green header, white cards, bottom nav).
class DriverDashboardView extends ConsumerStatefulWidget {
  const DriverDashboardView({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  ConsumerState<DriverDashboardView> createState() =>
      _DriverDashboardViewState();
}

class _DriverDashboardViewState extends ConsumerState<DriverDashboardView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 4);
  }

  List<Widget> get _tabs => [
        const DriverHomeTab(),
        const DriverRequestsTab(),
        const DriverEarningTab(),
        const DriverImpactTab(),
        const DriverProfileTab(),
      ];

  @override
  Widget build(BuildContext context) {
    final safeIndex =
        _tabs.isEmpty ? 0 : _currentIndex.clamp(0, _tabs.length - 1);
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFC),
      body: IndexedStack(
        index: safeIndex,
        children: _tabs,
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
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
              _DriverNavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _DriverNavItem(
                icon: Assets.requestsIcon,
                label: 'Requests',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              _DriverNavItem(
                icon: Assets.earningIcon,
                label: 'Earning',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _DriverNavItem(
                icon: Assets.impactIcon,
                label: 'Impact',
                isSelected: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
              _DriverNavItem(
                icon: Assets.navUserIcon,
                label: 'Profile',
                isSelected: _currentIndex == 4,
                onTap: () => setState(() => _currentIndex = 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DriverNavItem extends StatelessWidget {
  const _DriverNavItem({
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
    final color = isSelected
        ? AppColors.primaryColor
        : Colors.black.withValues(alpha: 0.5);
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
          ],
        ),
      ),
    );
  }
}
