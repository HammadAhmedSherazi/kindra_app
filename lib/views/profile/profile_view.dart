import '../../export_all.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String _demoName = 'Fajar Firmansyah';
  static const String _demoEmail = 'Fajar0123@gmail.com';
  static const int _demoRank = 5;
  static const int _demoPoints = 142;
  static const int _demoBadges = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: context.robotoFlexSemiBold(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    24.ph,
                    _buildUserSection(context),
                    28.ph,
                    Text(
                      'Account',
                      style: context.robotoFlexSemiBold(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    14.ph,
                    _buildYourRankCard(context),
                    20.ph,
                    _buildMenuItem(
                      context,
                      icon: Icons.edit_note_rounded,
                      label: 'Edit Profile',
                      onTap: () => AppRouter.push(const EditProfileView()),
                    ),
                    12.ph,
                    _buildMenuItem(
                      context,
                      icon: Icons.notifications_outlined,
                      label: 'Notification',
                      onTap: () => AppRouter.push(const NotificationView()),
                    ),
                    12.ph,
                    _buildMenuItem(
                      context,
                      icon: Icons.star_outline_rounded,
                      label: 'Reward',
                      onTap: () => AppRouter.push(const PointsView()),
                    ),
                    12.ph,
                    _buildMenuItem(
                      context,
                      icon: Icons.logout_rounded,
                      label: 'Logout',
                      isLogout: true,
                      onTap: () => AppRouter.pushReplacement(const LoginView()),
                    ),
                    40.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserSection(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.borderColor,
          backgroundImage: AssetImage(Assets.placeholder),
          onBackgroundImageError: (_, __) {},
        ),
        16.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _demoName,
                style: context.robotoFlexSemiBold(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              4.ph,
              Text(
                _demoEmail,
                style: context.robotoFlexRegular(
                  fontSize: 14,
                  color: AppColors.primaryTextColor.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYourRankCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFFE8F4E8),
            const Color(0xFFE0F2E8),
            AppColors.primaryColor.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.winBadgeIcon,
                    width: 26,
                    height: 26,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              12.pw,
              Text(
                'Your Rank',
                style: context.robotoFlexSemiBold(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          20.ph,
          Row(
            children: [
              _buildRankStat(
                value: '#$_demoRank',
                label: 'Rank',
                color: const Color(0xFF2563EB),
              ),
              32.pw,
              _buildRankStat(
                value: '$_demoPoints',
                label: 'Points',
                color: AppColors.primaryColor,
              ),
              32.pw,
              _buildRankStat(
                value: '$_demoBadges',
                label: 'Badges',
                color: const Color(0xFF7C3AED),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankStat({
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: color,
          ),
        ),
        2.ph,
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.primaryTextColor.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.red : AppColors.primaryTextColor;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isLogout
                  ? Colors.red.withValues(alpha: 0.3)
                  : AppColors.borderColor,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isLogout
                      ? Colors.red.withValues(alpha: 0.1)
                      : AppColors.borderColor.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 22, color: color),
              ),
              14.pw,
              Expanded(
                child: Text(
                  label,
                  style: context.robotoFlexMedium(
                    fontSize: 15,
                    color: color,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: color.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

