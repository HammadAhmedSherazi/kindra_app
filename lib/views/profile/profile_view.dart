import 'dart:math' as math;

import '../../export_all.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  static const int _demoRank = 5;
  static const int _demoPoints = 142;
  static const int _demoBadges = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          style: context.robotoFlexBold(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Profile',
                    //       textAlign: TextAlign.center,
                    //       style: context.robotoFlexSemiBold(
                    //         fontSize: 20,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // 24.ph,
                    _buildUserSection(context, profileAsync),
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
                      onTap: () => showLogoutDialog(context),
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

  Widget _buildUserSection(
    BuildContext context,
    AsyncValue<UserProfile?> profileAsync,
  ) {
    return GestureDetector(
      onTap: () => AppRouter.push(const ProfileDetailView()),
      child: Row(
        children: [
          profileAsync.when(
            data: (p) {
              final photoUrl = p?.photoUrl ?? '';
              if (photoUrl.isNotEmpty) {
                return CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(photoUrl),
                );
              }
              return CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Image.asset(
                  Assets.userAvatar,
                  color: AppColors.primaryColor,
                ),
              );
            },
            loading: () => const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (error, stackTrace) => CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Image.asset(
                Assets.userAvatar,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileAsync.maybeWhen(
                        data: (p) =>
                            (p?.displayName.isNotEmpty == true)
                                ? p!.displayName
                                : null,
                        orElse: () => null,
                      ) ??
                      (FirebaseAuthService
                                  .instance.currentUserDisplayName
                                  ?.trim()
                                  .isNotEmpty ==
                              true
                          ? FirebaseAuthService
                              .instance.currentUserDisplayName!
                          : 'User'),
                  style: context.robotoFlexSemiBold(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  profileAsync.maybeWhen(
                        data: (p) =>
                            (p?.email.isNotEmpty == true) ? p!.email : null,
                        orElse: () => null,
                      ) ??
                      (FirebaseAuthService.instance.currentUserEmail
                                  ?.trim()
                                  .isNotEmpty ==
                              true
                          ? FirebaseAuthService.instance.currentUserEmail!
                          : ''),
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
