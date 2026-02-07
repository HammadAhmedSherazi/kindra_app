import '../../export_all.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({super.key, this.initialIndex = 0});

  /// Tab to show when opened (0=Home, 1=Training, 2=Reward, 3=Profile).
  final int initialIndex;

  @override
  ConsumerState<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerState<NavigationView> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, 3);
  }

  final List<Widget> _tabs = const [
    HomeView(),
    TrainerView(),
    RewardView(),
    ProfileView(),
  ];

  void _onFabPressed() {
    // Center FAB action - e.g. create post, add item, etc.
    AppRouter.push(const UsedOilHandoverView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      floatingActionButton: _buildCenterFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildCenterFab(BuildContext context) {
    return Container(
      width: 97,
      height: 97,
      margin: const EdgeInsets.only(top: 24),
      child: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.50),
        elevation: 0,
        shape: CircleBorder(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(Assets.scanDocIcon),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Assets.navHomeIcon,
                label: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _NavItem(
                icon: Assets.navTrainerIcon,
                label: 'Training',
                isSelected: _currentIndex == 1,
                onTap: () => setState(() => _currentIndex = 1),
              ),
              100.pw,
              _NavItem(
                icon: Assets.navRewardIcon,
                label: 'Reward',
                isSelected: _currentIndex == 2,
                onTap: () => setState(() => _currentIndex = 2),
              ),
              _NavItem(
                icon: Assets.navUserIcon,
                label: 'Profile',
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
    final color = isSelected
        ? AppColors.primaryColor
        : Colors.black.withValues(alpha: 0.55);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 30, height: 30, color: color),

            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
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

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('home')),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.tr('welcome_message'),
              style: context.textStyle.titleMedium,
              textAlign: TextAlign.center,
            ),
            24.ph,
            ElevatedButton(
              onPressed: () => AppRouter.pushReplacement(const LoginView()),
              child: Text(context.tr('logout')),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreTab extends StatelessWidget {
  const _ExploreTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          'Explore',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto Flex',
            color: AppColors.primaryTextColor,
          ),
        ),
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  const _ActivityTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          'Activity',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto Flex',
            color: AppColors.primaryTextColor,
          ),
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto Flex',
            color: AppColors.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
