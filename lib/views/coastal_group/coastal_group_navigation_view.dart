import '../../export_all.dart';

/// Coastal Group flow: 5 tabs — Dashboard, Cleanups, Report, Reward, Profile.
/// Push this view to enter the Coastal Group experience (e.g. from login or group selection).
class CoastalGroupNavigationView extends ConsumerStatefulWidget {
  const CoastalGroupNavigationView({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  ConsumerState<CoastalGroupNavigationView> createState() =>
      _CoastalGroupNavigationViewState();
}

class _CoastalGroupNavigationViewState
    extends ConsumerState<CoastalGroupNavigationView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 4);
  }

  final List<Widget> _tabs = const [
    CoastalGroupDashboardTab(),
    CoastalGroupCleanupsTab(),
    CoastalGroupReportTab(),
    CoastalGroupRewardTab(),
    CoastalGroupProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: IndexedStack(
        index: _currentIndex,
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
              _CoastalNavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _CoastalNavItem(
                icon: Assets.cleanupIcon,
                label: 'Cleanups',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              _CoastalNavItem(
                icon: Assets.reportIcon,
                label: 'Report',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _CoastalNavItem(
                icon: Assets.giftIconPng,
                label: 'Reward',
                isSelected: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
              _CoastalNavItem(
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

class _CoastalNavItem extends StatelessWidget {
  const _CoastalNavItem({
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
            Image.asset(icon, width: 26, height: 26, color: color),
            6.ph,
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
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
