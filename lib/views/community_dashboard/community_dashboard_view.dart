import '../../export_all.dart';

class CommunityDashboardView extends ConsumerStatefulWidget {
  const CommunityDashboardView({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  ConsumerState<CommunityDashboardView> createState() =>
      _CommunityDashboardViewState();
}

class _CommunityDashboardViewState
    extends ConsumerState<CommunityDashboardView> {
  late int _currentIndex;

  static const double _headerHeight = 250;

  static const List<String> _sectionTitles = [
    '',
    'Pickups',
    'Members Overview',
    'Impact',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 3);
  }

  final List<Widget> _tabs = const [
    CommunityHomeTab(),
    CommunityPickupTab(),
    CommunityMemberTab(),
    CommunityImpactTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFC),
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
              _CommunityNavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _CommunityNavItem(
                icon: Assets.nextPickupIcon,
                label: 'Pickup',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              _CommunityNavItem(
                icon: Assets.communityMemberIcon,
                label: 'Member',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _CommunityNavItem(
                icon: Assets.environmentImpactIcon,
                label: 'Impact',
                isSelected: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommunityNavItem extends StatelessWidget {
  const _CommunityNavItem({
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
