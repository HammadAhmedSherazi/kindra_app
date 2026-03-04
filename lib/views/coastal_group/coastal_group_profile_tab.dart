import '../../export_all.dart';

/// Profile tab: Coastal Group profile, stats, impact, group members list, Logout.
class CoastalGroupProfileTab extends StatelessWidget {
  const CoastalGroupProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = MediaQuery.paddingOf(context).top + 60;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _ProfileAppBar(),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: _GroupProfileCard(),
                ),
                16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _StatsRow(),
                        24.ph,
                        Text(
                          "Coastal Group's Impact",
                          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                        ),
                        12.ph,
                        _ImpactRow(),
                        24.ph,
                        Text(
                          'Group Members',
                          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
                        ),
                        12.ph,
                        _MemberTile(name: 'Sam', role: 'Team leader'),
                        _MemberTile(name: 'Alyssa', role: 'Eco Enthusiast'),
                        _MemberTile(name: 'Mike', role: 'Cleanup Volunteer'),
                        _MemberTile(name: 'Emma', role: 'Cleanup Volunteer'),
                        24.ph,
                        CustomButtonWidget(
                          label: 'Logout',
                          onPressed: () => AppRouter.pushAndRemoveUntil(const LoginView()),
                          height: 52,
                          backgroundColor: Colors.grey.shade700,
                        ),
                        100.ph,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 8,
        left: 8,
        right: 20,
        bottom: 14,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          IconButton(
            onPressed: () => AppRouter.back(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Expanded(
            child: Text(
              'Members',
              style: context.robotoFlexBold(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => AppRouter.push(const NotificationView()),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(Assets.notificationIcon, width: 26, height: 26),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 10,
                    height: 10,
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
    );
  }
}

class _GroupProfileCard extends StatelessWidget {
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
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: AssetImage(Assets.userAvatar),
          ),
          16.ph,
          Text(
            'Coastal Group',
            style: context.robotoFlexBold(fontSize: 22, color: Colors.black),
          ),
          8.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.locationIcon, width: 18, height: 18),
              6.pw,
              Text(
                'Arcata Bay',
                style: context.robotoFlexRegular(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
          6.ph,
          Text(
            'Restoring Our Oceans',
            style: context.robotoFlexMedium(fontSize: 14, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatBox(value: '128', label: 'Members')),
        12.pw,
        Expanded(child: _StatBox(value: '36', label: 'Cleanups')),
        12.pw,
        Expanded(child: _StatBox(value: '1,720 lbs', label: 'Waste Collected')),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 20, color: Colors.black),
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(fontSize: 12, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ImpactRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatBox(value: '+12,700', label: 'Eco Points Earned')),
        12.pw,
        Expanded(child: _StatBox(value: '420', label: 'Cleanups Completed')),
        12.pw,
        Expanded(child: _StatBox(value: '450', label: 'Volunteer Hours')),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.name, required this.role});

  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: AssetImage(Assets.userAvatar),
          ),
          14.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.robotoFlexBold(fontSize: 15, color: Colors.black),
                ),
                2.ph,
                Text(
                  role,
                  style: context.robotoFlexRegular(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade500),
        ],
      ),
    );
  }
}
