import 'dart:math' as math;

import '../../export_all.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const int _demoRank = 5;
  static const int _demoPoints = 142;
  static const int _demoBadges = 3;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed title (Reward/Award tab style)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Scroll only the body content
            Expanded(
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
                          Consumer(
                            builder: (context, ref, _) {
                              final photoUrl = ref.watch(
                                currentUserBaseProvider.select(
                                  (async) => async.maybeWhen(
                                    data: (p) => p?.photoUrl ?? '',
                                    orElse: () => '',
                                  ),
                                ),
                              );
                              final displayName = ref.watch(
                                currentUserBaseProvider.select((async) {
                                  final fromFirestore = async.maybeWhen(
                                    data: (p) =>
                                        (p?.displayName.isNotEmpty == true)
                                            ? p!.displayName
                                            : null,
                                    orElse: () => null,
                                  );
                                  if (fromFirestore != null &&
                                      fromFirestore.trim().isNotEmpty) {
                                    return fromFirestore;
                                  }
                                  final authName = FirebaseAuthService
                                      .instance.currentUserDisplayName;
                                  return (authName != null &&
                                          authName.trim().isNotEmpty)
                                      ? authName
                                      : 'User';
                                }),
                              );
                              final email = ref.watch(
                                currentUserBaseProvider.select((async) {
                                  final fromFirestore = async.maybeWhen(
                                    data: (p) =>
                                        (p?.email.isNotEmpty == true)
                                            ? p!.email
                                            : null,
                                    orElse: () => null,
                                  );
                                  if (fromFirestore != null &&
                                      fromFirestore.trim().isNotEmpty) {
                                    return fromFirestore;
                                  }
                                  final authEmail = FirebaseAuthService
                                      .instance.currentUserEmail;
                                  return (authEmail != null &&
                                          authEmail.trim().isNotEmpty)
                                      ? authEmail
                                      : '';
                                }),
                              );

                              return _buildUserSection(
                                context,
                                photoUrl: photoUrl,
                                displayName: displayName,
                                email: email,
                              );
                            },
                          ),
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
                            onTap: () =>
                                AppRouter.push(const EditProfileView()),
                          ),
                          12.ph,
                          _buildMenuItem(
                            context,
                            icon: Assets.notificationIcon,
                            label: 'Notification',
                            onTap: () =>
                                AppRouter.push(const NotificationView()),
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
          ],
        ),
      ),
    );
  }

  Widget _buildUserSection(
    BuildContext context,
    {
    required String photoUrl,
    required String displayName,
    required String email,
  }
  ) {
    return GestureDetector(
      onTap: () => AppRouter.push(const ProfileDetailView()),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
            child: photoUrl.isEmpty
                ? Image.asset(
                    Assets.userAvatar,
                    color: AppColors.primaryColor,
                  )
                : null,
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: context.robotoFlexSemiBold(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  email,
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
