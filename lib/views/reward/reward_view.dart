import '../../export_all.dart';

class RewardView extends StatefulWidget {
  const RewardView({super.key});

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  int _selectedTabIndex = 0;

  final List<LeaderboardUser> _leaderboardUsers = [
    LeaderboardUser(name: 'Jhon', level: 3, items: 45, badges: 6, points: 230),
    LeaderboardUser(name: 'Fajar', level: 2, items: 32, badges: 4, points: 180),
    LeaderboardUser(name: 'John', level: 2, items: 28, badges: 5, points: 165),
    LeaderboardUser(name: 'Priya', level: 2, items: 31, badges: 3, points: 155),
    LeaderboardUser(name: 'You (You)', level: 2, items: 10, badges: 3, points: 142, isCurrentUser: true),
    LeaderboardUser(name: 'Vikram', level: 2, items: 25, badges: 4, points: 138),
    LeaderboardUser(name: 'Sneha', level: 2, items: 22, badges: 2, points: 125),
    LeaderboardUser(name: 'Karan', level: 2, items: 20, badges: 3, points: 115),
  ];

  final List<BadgeItem> _badges = [
    BadgeItem(title: 'First Recycle', desc: 'Complete your first recycle', icon: Assets.winBadgeIcon, isUnlocked: true),
    BadgeItem(title: 'Eco Warrior', desc: 'Recycle 10 items', icon: Assets.rewardIcon, isUnlocked: true),
    BadgeItem(title: 'Green Champion', desc: 'Recycle 50 items', icon: Assets.winIcon, isUnlocked: true),
    BadgeItem(title: 'Recycling Master', desc: 'Recycle 100 items', icon: Assets.winBadgeIcon, isUnlocked: false),
    BadgeItem(title: 'Weekly Hero', desc: 'Complete weekly challenge', icon: Assets.rewardIcon, isUnlocked: false),
    BadgeItem(title: 'Top 10', desc: 'Reach top 10 in leaderboard', icon: Assets.winIcon, isUnlocked: false),
  ];

  final List<RewardItem> _rewards = [
    RewardItem(title: 'Eco Bag', desc: 'Reusable shopping bag', points: 500, icon: Assets.shopBagIcon),
    RewardItem(title: 'Gift Voucher \$5', desc: 'Redeem at partner stores', points: 1000, icon: Assets.giftIcon),
    RewardItem(title: 'Plant Sapling', desc: 'Plant a tree in your name', points: 2000, icon: Assets.rewardIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    24.ph,
                    _buildLeaderboardSection(),
                    24.ph,
                    if (_selectedTabIndex == 0) _buildRankingTab()
                    else if (_selectedTabIndex == 1) _buildBadgesTab()
                    else _buildRewardsTab(),
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

  Widget _buildHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Award',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(Assets.winIcon, width: 24, height: 24, ),
            10.pw,
            Text(
              'Leaderboard & Achievements',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        16.ph,
        _buildSegmentTabs(),
      ],
    );
  }

  Widget _buildSegmentTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _SegmentTab(
            label: 'Ranking',
            isSelected: _selectedTabIndex == 0,
            onTap: () => setState(() => _selectedTabIndex = 0),
          ),
          _SegmentTab(
            label: 'Badges',
            isSelected: _selectedTabIndex == 1,
            onTap: () => setState(() => _selectedTabIndex = 1),
          ),
          _SegmentTab(
            label: 'Rewards',
            isSelected: _selectedTabIndex == 2,
            onTap: () => setState(() => _selectedTabIndex = 2),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading(Assets.rewardIcon, 'Global Leaderboard'),
        16.ph,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: List.generate(_leaderboardUsers.length * 2 - 1, (index) {
              if (index.isOdd) {
                return Divider(height: 1, color: Colors.black.withValues(alpha: 0.08));
              }
              final userIndex = index ~/ 2;
              final user = _leaderboardUsers[userIndex];
              return _LeaderboardRow(user: user, rank: userIndex + 1);
            }),
          ),
        ),
        24.ph,
        _buildSectionHeading(Assets.rewardIcon, 'Weekly Challenge'),
        16.ph,
        _buildWeeklyChallengeCard(),
      ],
    );
  }

  Widget _buildBadgesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading(Assets.rewardIcon, 'Your Badges'),
        16.ph,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: _badges.length,
          itemBuilder: (context, index) {
            final badge = _badges[index];
            return _BadgeCard(badge: badge);
          },
        ),
        24.ph,
        _buildSectionHeading(Assets.rewardIcon, 'Weekly Challenge'),
        16.ph,
        _buildWeeklyChallengeCard(),
      ],
    );
  }

  Widget _buildRewardsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeading(Assets.rewardIcon, 'Available Rewards'),
        16.ph,
        ...List.generate(_rewards.length, (index) {
          final reward = _rewards[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _RewardCard(reward: reward),
          );
        }),
        24.ph,
        _buildSectionHeading(Assets.rewardIcon, 'Weekly Challenge'),
        16.ph,
        _buildWeeklyChallengeCard(),
      ],
    );
  }

  Widget _buildSectionHeading(String iconPath, String title) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 24, height: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
        10.pw,
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Roboto Flex',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyChallengeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E0F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recycle 5 Items This Week',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w600,
            ),
          ),
          8.ph,
          Text(
            'Join 234 other users in this week\'s recycling challenge!',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.7),
              fontSize: 14,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w400,
            ),
          ),
          16.ph,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF7B68EE).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+50 Bonus Points',
              style: TextStyle(
                color: const Color(0xFF5B4BBE),
                fontSize: 15,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardUser {
  final String name;
  final int level;
  final int items;
  final int badges;
  final int points;
  final bool isCurrentUser;

  LeaderboardUser({
    required this.name,
    required this.level,
    required this.items,
    required this.badges,
    required this.points,
    this.isCurrentUser = false,
  });
}

class BadgeItem {
  final String title;
  final String desc;
  final String icon;
  final bool isUnlocked;

  BadgeItem({required this.title, required this.desc, required this.icon, required this.isUnlocked});
}

class RewardItem {
  final String title;
  final String desc;
  final int points;
  final String icon;

  RewardItem({required this.title, required this.desc, required this.points, required this.icon});
}

class _SegmentTab extends StatelessWidget {
  const _SegmentTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.black.withValues(alpha: 0.5),
                fontSize: 14,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({
    required this.user,
    required this.rank,
  });

  final LeaderboardUser user;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final initial = user.name.startsWith('You') ? 'Y' : user.name[0];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: user.isCurrentUser ? const Color(0xFFF5F5F5) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (rank <= 3) ...[_buildRankIcon(), 6.pw],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          12.pw,
          CircleAvatar(
            radius: 22,
            backgroundColor: user.isCurrentUser ? const Color(0xFF4A90E2) : const Color(0xFFE0E0E0),
            child: Text(
              initial,
              style: TextStyle(
                color: user.isCurrentUser ? Colors.white : Colors.black54,
                fontSize: 18,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          12.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.ph,
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Level ${user.level}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                2.ph,
                Text(
                  '${user.items} items • ${user.badges} badges',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${user.points}',
                style: TextStyle(
                  color: user.isCurrentUser ? const Color(0xFF4A90E2) : Colors.black,
                  fontSize: 16,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'points',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankIcon() {
    if (rank == 1) {
      return Icon(Icons.workspace_premium, color: const Color(0xFFD4AF37), size: 24);
    }
    if (rank == 2) {
      return Icon(Icons.emoji_events, color: const Color(0xFFC0C0C0), size: 24);
    }
    if (rank == 3) {
      return Icon(Icons.military_tech, color: const Color(0xFFCD7F32), size: 24);
    }
    return const SizedBox.shrink();
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final BadgeItem badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: badge.isUnlocked ? const Color(0xFFF9FAFC) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            badge.icon,
            width: 48,
            height: 48,
            colorFilter: badge.isUnlocked
                ? null
                : ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
          ),
          12.ph,
          Text(
            badge.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: badge.isUnlocked ? Colors.black : Colors.black54,
              fontSize: 14,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w600,
            ),
          ),
          4.ph,
          Text(
            badge.desc,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 11,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({required this.reward});

  final RewardItem reward;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(reward.icon, width: 32, height: 32),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.ph,
                Text(
                  reward.desc,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${reward.points}',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'points',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
