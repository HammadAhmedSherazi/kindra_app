import 'dart:math' as math;

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Profile',
                          textAlign: TextAlign.center,
                          style: context.robotoFlexSemiBold(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
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
                      icon: Assets.editProfileIcon,
                      label: 'Edit Profile',
                      onTap: () => AppRouter.push(const EditProfileView()),
                    ),
                    12.ph,
                    _buildMenuItem(
                      context,
                      icon: Assets.notificationIcon,
                      label: 'Notification',
                      onTap: () => AppRouter.push(const NotificationView()),
                    ),
                    12.ph,
                    _buildMenuItem(
                      context,
                      icon: Assets.medalIcon,
                      label: 'Reward',
                      onTap: () => AppRouter.push(const PointsView()),
                    ),
                    12.ph,
                    _buildMenuItem(
                      context,
                      icon: Assets.logoutIcon,
                      label: 'Logout',
                      isLogout: true,
                      onTap: () => showExitAppDialog(context),
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
    return GestureDetector(
      onTap: () => AppRouter.push(const ProfileDetailView()),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            // backgroundImage: AssetImage(Assets.userAvatar,),
            child: Image.asset(Assets.userAvatar, color: AppColors.primaryColor,),
            // onBackgroundImageError: (_, __) {},
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
      ),
    );
  }

  Widget _buildYourRankCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0xFFEEF5FE), const Color(0xFFF0FDF4)],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.05, color: const Color(0xFFBDDAFF)),
          borderRadius: BorderRadius.circular(12.75),
        ),
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
                  shape: BoxShape.circle,
                  color: const Color(0xFFDBEAFE),
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.workspace_premium_outlined,
                  size: 22,
                  color: const Color(0xFF2563EB),
                ),
              ),
              12.pw,
              Expanded(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Rank',
                      style: context.robotoFlexRegular(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),

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
            fontWeight: FontWeight.w300,
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
    required dynamic icon,
    required String label,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.red : Color(0xff3A3A3A);
    final iconWidget = icon is String
        ? (icon.endsWith('.png')
            ? Image.asset(icon, color: color, colorBlendMode: BlendMode.srcIn)
            : SvgPicture.asset(icon, colorFilter: ColorFilter.mode(color, BlendMode.srcIn),width: 24, height: 24,))
        : Icon(icon as IconData, color: color, size: 24);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(50),
              right: Radius.circular(50),
            ),
            border: Border.all(
              color: isLogout
                  ? Colors.red
                  : Color(0xff3A3A3A).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: isLogout
                      ? Colors.red
                      : Color(0xff3A3A3A).withValues(alpha: 0.3),),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: iconWidget,
              ),
              14.pw,
              Expanded(
                child: Text(
                  label,
                  style: context.robotoFlexMedium(fontSize: 15, color: color),
                ),
              ),
              Transform.rotate(
                angle: -(45 * math.pi / 180),
                child: Icon(
                  Icons.arrow_forward,
                  size: 24,
                  color: color,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
