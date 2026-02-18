import '../../export_all.dart';

/// Business unit flow dashboard (third flow).
/// Tabs: Home, Pickup, Payment, Impact, Profile.
class BusinessDashboardView extends ConsumerStatefulWidget {
  const BusinessDashboardView({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  ConsumerState<BusinessDashboardView> createState() =>
      _BusinessDashboardViewState();
}

class _BusinessDashboardViewState extends ConsumerState<BusinessDashboardView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 4);
  }

  List<Widget> get _tabs => [
    const BusinessHomeTab(),
    const BusinessPickupTab(),
    const BusinessPaymentTab(),
    const BusinessImpactTab(),
    const BusinessProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final safeIndex = _tabs.isEmpty ? 0 : _currentIndex.clamp(0, _tabs.length - 1);
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
              _BusinessNavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _BusinessNavItem(
                icon: Assets.pickupIcon,
                label: 'Pickup',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              _BusinessNavItem(
                icon: Assets.paymentIcon,
                label: 'Payment',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _BusinessNavItem(
                icon: Assets.impactIcon,
                label: 'Impact',
                isSelected: _currentIndex == 3,
                onTap: () => setState(() => _currentIndex = 3),
              ),
              _BusinessNavItem(
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

class _BusinessNavItem extends StatelessWidget {
  const _BusinessNavItem({
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
