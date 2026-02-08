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
    LeaderboardUser(
      name: 'You (You)',
      level: 2,
      items: 10,
      badges: 3,
      points: 142,
      isCurrentUser: true,
    ),
    LeaderboardUser(
      name: 'Vikram',
      level: 2,
      items: 25,
      badges: 4,
      points: 138,
    ),
    LeaderboardUser(name: 'Sneha', level: 2, items: 22, badges: 2, points: 125),
    LeaderboardUser(name: 'Karan', level: 2, items: 20, badges: 3, points: 115),
  ];

  final List<BadgeItem> _badges = [
    BadgeItem(
      title: 'First Recycle',
      desc: 'Complete your first recycle',
      icon: Assets.winBadgeIcon,
      isUnlocked: true,
    ),
    BadgeItem(
      title: 'Eco Warrior',
      desc: 'Recycle 10 items',
      icon: Assets.rewardIcon,
      isUnlocked: true,
    ),
    BadgeItem(
      title: 'Green Champion',
      desc: 'Recycle 50 items',
      icon: Assets.winIcon,
      isUnlocked: true,
    ),
    BadgeItem(
      title: 'Recycling Master',
      desc: 'Recycle 100 items',
      icon: Assets.winBadgeIcon,
      isUnlocked: false,
    ),
    BadgeItem(
      title: 'Weekly Hero',
      desc: 'Complete weekly challenge',
      icon: Assets.rewardIcon,
      isUnlocked: false,
    ),
    BadgeItem(
      title: 'Top 10',
      desc: 'Reach top 10 in leaderboard',
      icon: Assets.winIcon,
      isUnlocked: false,
    ),
  ];

  final List<RewardItem> _rewards = [
    RewardItem(
      title: 'Eco Bag',
      desc: 'Reusable shopping bag',
      points: 500,
      icon: Assets.shopBagIcon,
    ),
    RewardItem(
      title: 'Gift Voucher \$5',
      desc: 'Redeem at partner stores',
      points: 1000,
      icon: Assets.giftIcon,
    ),
    RewardItem(
      title: 'Plant Sapling',
      desc: 'Plant a tree in your name',
      points: 2000,
      icon: Assets.rewardIcon,
    ),
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
                    if (_selectedTabIndex == 0)
                      _buildRankingTab()
                    else if (_selectedTabIndex == 1)
                      _buildBadgesTab()
                    else
                      _buildRewardsTab(),
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
            SvgPicture.asset(Assets.winIcon, width: 24, height: 24),
            10.pw,
            Text(
              'Leaderboard & Achievements',
              style: TextStyle(
                color: const Color(0xFF0A0A0A),
                fontSize: 15.75,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.56,
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
      height: 34,
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.05,
                color: Colors.black.withValues(alpha: 0.10),
              ),
              borderRadius: BorderRadius.circular(12.75),
            ),
          ),
          child: Column(
            children: [
              _buildSectionHeading(Assets.winIcon, 'Global Leaderboard'),
              16.ph,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final user = _leaderboardUsers[index];
                  return _LeaderboardRow(user: user, rank: index + 1);
                },
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black.withValues(alpha: 0.08)),
                itemCount: _leaderboardUsers.length,
              ),
            ],
          ),
        ),

        //  16.ph,
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: Column(
        //     children: List.generate(_leaderboardUsers.length * 2 - 1, (index) {
        //       if (index.isOdd) {
        //         return Divider(
        //           height: 1,
        //           color: Colors.black.withValues(alpha: 0.08),
        //         );
        //       }
        //       final userIndex = index ~/ 2;
        //       final user = _leaderboardUsers[userIndex];
        //       return _LeaderboardRow(user: user, rank: userIndex + 1);
        //     }),
        //   ),
        // ),
        24.ph,

        _buildWeeklyChallengeCard(),
      ],
    );
  }

  Widget _buildBadgesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.05,
                color: Colors.black.withValues(alpha: 0.10),
              ),
              borderRadius: BorderRadius.circular(12.75),
            ),
          ),
          child: Column(
            spacing: 10,
            children: [
              Row(
                spacing: 15,
                children: [
                  Container(
                    width: 41.95,
                    height: 41.95,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.only(top: 10.48, left: 10.48, right: 10.48),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFEF9C2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.75),
                      ),
                    ),
                    child: SvgPicture.asset(
                      Assets.winIcon,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Color(0xffD08700),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Achievements',
                          style: TextStyle(
                            color: const Color(0xFF0A0A0A),
                            fontSize: 15.75,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.56,
                          ),
                        ),
                        Text(
                          '3 of 8 earned',
                          style: TextStyle(
                            color: const Color(0xFF717182),
                            fontSize: 12.25,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overall Progress',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  Text(
                    '3/8',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 3 / 8, // 3 out of 8 badges earned
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          'Starter Achievements',
          style: TextStyle(
            color: const Color(0xFF0A0A0A),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        AchievementWidgetCard(
          icon: '🟢',
          title: 'Eco Starter',
          desc: 'First time waste disposed properly',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          'Specialist Achievements',
          style: TextStyle(
            color: const Color(0xFF0A0A0A),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        AchievementWidgetCard(
          icon: '♻️',
          backgroundColor: Colors.white,
          borderColor: Colors.black.withValues(alpha: 0.10),
          title: 'Plastic Warrior',
          desc: '10 plastic items recycled',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '3/10 plastics',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  Text(
                    '40%',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 3 / 8, // 3 out of 8 badges earned
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 1.75,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFECEEF2),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.05,
                      color: Colors.black.withValues(alpha: 0),
                    ),
                    borderRadius: BorderRadius.circular(6.75),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 3.50,
                  children: [
                    Text(
                      '+50 pts',
                      style: TextStyle(
                        color: const Color(0xFF030213),
                        fontSize: 10.50,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        AchievementWidgetCard(
          icon: '🌿',
          backgroundColor: Colors.white,
          borderColor: Colors.black.withValues(alpha: 0.10),
          title: 'Composting Champion',
          desc: '5 food items composted',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '2/5 composted',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  Text(
                    '30%',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.4, // 3 out of 8 badges earned
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 1.75,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFECEEF2),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.05,
                      color: Colors.black.withValues(alpha: 0),
                    ),
                    borderRadius: BorderRadius.circular(6.75),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 3.50,
                  children: [
                    Text(
                      '+40 pts',
                      style: TextStyle(
                        color: const Color(0xFF030213),
                        fontSize: 10.50,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        AchievementWidgetCard(
          icon: '📱',
          backgroundColor: Colors.white,
          borderColor: Colors.black.withValues(alpha: 0.10),
          title: 'Tech Recycler',
          desc: '3 electronic items recycled',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '1/3 electronics',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  Text(
                    '33%',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.33, // 3 out of 8 badges earned
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 1.75,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFECEEF2),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.05,
                      color: Colors.black.withValues(alpha: 0),
                    ),
                    borderRadius: BorderRadius.circular(6.75),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 3.50,
                  children: [
                    Text(
                      '+60 pts',
                      style: TextStyle(
                        color: const Color(0xFF030213),
                        fontSize: 10.50,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Text(
          'Milestone Achievements',
          style: TextStyle(
            color: const Color(0xFF0A0A0A),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        AchievementWidgetCard(
          icon: '🌱',

          title: 'Green Hero',
          desc: '100+ points earned',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
        ),
        AchievementWidgetCard(
          icon: '🏆',
          backgroundColor: Colors.white,
          borderColor: Colors.black.withValues(alpha: 0.10),
          title: 'Eco Champion',
          desc: '250+ points earned',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '142/250 points',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  Text(
                    '57%',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.33, // 3 out of 8 badges earned
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 1.75,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFECEEF2),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.05,
                      color: Colors.black.withValues(alpha: 0),
                    ),
                    borderRadius: BorderRadius.circular(6.75),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 3.50,
                  children: [
                    Text(
                      '+150 pts',
                      style: TextStyle(
                        color: const Color(0xFF030213),
                        fontSize: 10.50,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        AchievementWidgetCard(
          icon: '⭐',
          backgroundColor: Colors.white,
          borderColor: Colors.black.withValues(alpha: 0.10),
          title: 'Master Recycler',
          desc: '50 items properly disposed',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '7/50 items',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  Text(
                    '14%',
                    style: TextStyle(
                      color: const Color(0xFF717182),
                      fontSize: 10.50,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.14, // 3 out of 8 badges earned
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 1.75,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFECEEF2),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1.05,
                      color: Colors.black.withValues(alpha: 0),
                    ),
                    borderRadius: BorderRadius.circular(6.75),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 3.50,
                  children: [
                    Text(
                      '+150 pts',
                      style: TextStyle(
                        color: const Color(0xFF030213),
                        fontSize: 10.50,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Text(
          'Community Achievements',
          style: TextStyle(
            color: const Color(0xFF0A0A0A),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        AchievementWidgetCard(
          icon: '🤝',

          title: 'Community Saver',
          desc: 'Clothes donated to charity',
          status: 'Earned',
          date: '12/18/2025',
          secondIcon: Image.asset(
            Assets.checkedIcon,
            width: 14,
            height: 14,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Container(
          width: double.infinity,

          padding: EdgeInsets.all(20),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, 0.50),
              end: Alignment(1.00, 0.50),
              colors: [const Color(0xFFF0FDF4), const Color(0xFFEEF5FE)],
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.05, color: const Color(0xFFB8F7CF)),
              borderRadius: BorderRadius.circular(12.75),
            ),
          ),
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 41.95,
                height: 41.95,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffDCFCE7),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3.48,
                  children: [
                    Text(
                      'Available Points',
                      style: TextStyle(
                        color: const Color(0xFF0A0A0A),
                        fontSize: 15.75,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.56,
                      ),
                    ),
                    Text(
                      '142',
                      style: TextStyle(
                        color: const Color(0xFF00A63E),
                        fontSize: 26.25,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    Text(
                      'You can redeem 5 rewards',
                      style: TextStyle(
                        color: const Color(0xFF717182),
                        fontSize: 12.25,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.05,
                color: Colors.black.withValues(alpha: 0.10),
              ),
              borderRadius: BorderRadius.circular(12.75),
            ),
          ),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.giftIcon, width: 18, height: 18),
                  10.pw,
                  Text(
                    'Next Reward Goal',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 14,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Plant Store Voucher',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                  Text(
                    '142/150 pts',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontSize: 12.25,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0x33030213),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 142 / 150,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF030213),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Text(
                '8 more points needed',
                style: TextStyle(
                  color: const Color(0xFF717182),
                  fontSize: 10.50,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),
            ],
          ),
        ),
        Container(
           padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
color: Colors.white,
shape: RoundedRectangleBorder(
side: BorderSide(
width: 1.05,
color: Colors.black.withValues(alpha: 0.10),
),
borderRadius: BorderRadius.circular(12.75),
),
),
child: Column(
  children: [
     Row(
                children: [
                  SvgPicture.asset(Assets.giftIcon, width: 18, height: 18),
                  10.pw,
                  Text(
    'Available Rewards',
    style: TextStyle(
        color: const Color(0xFF0A0A0A),
        fontSize: 14,
        fontFamily: 'Arimo',
        fontWeight: FontWeight.w400,
        height: 1,
    ),
)
                ],
              ),


  ],
),
        )
      ],
    );
  }

  Widget _buildSectionHeading(String iconPath, String title) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            Color(0xFFF0B100),
            BlendMode.srcIn,
          ),
        ),
        10.pw,
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF0A0A0A),
            fontSize: 14,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w400,
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyChallengeCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.05,
            color: Colors.black.withValues(alpha: 0.10),
          ),
          borderRadius: BorderRadius.circular(12.75),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🏆 Weekly Challenge',
            style: TextStyle(
              color: const Color(0xFF0A0A0A),
              fontSize: 14,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          16.ph,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, 0.50),
                end: Alignment(1.00, 0.50),
                colors: [const Color(0xFFFAF5FE), const Color(0xFFFCF1F7)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.75),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Recycle 5 Items This Week',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF0A0A0A),
                    fontSize: 14,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
                8.ph,
                Text(
                  "Join 234 other users in this week's recycling challenge!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF717182),
                    fontSize: 12,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                16.ph,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3E8FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.05,
                        color: Colors.black.withValues(alpha: 0),
                      ),
                      borderRadius: BorderRadius.circular(6.75),
                    ),
                  ),
                  child: Text(
                    '+50 Bonus Points',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF8200DA),
                      fontSize: 12.0,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
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

class AchievementWidgetCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;
  final String status;
  final String date;
  final Widget secondIcon;
  final Widget? trailing;
  final Color? backgroundColor, borderColor;
  const AchievementWidgetCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.status,
    required this.date,
    required this.secondIcon,
    this.trailing,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: ShapeDecoration(
        color: backgroundColor,
        gradient: backgroundColor == null
            ? LinearGradient(
                begin: Alignment(0.00, 0.00),
                end: Alignment(1.00, 1.00),
                colors: [const Color(0xFFFDFBE8), const Color(0xFFFFF7EC)],
              )
            : null,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.05,
            color: borderColor ?? const Color(0xFFFEEF85),
          ),
          borderRadius: BorderRadius.circular(12.75),
        ),
      ),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Text(
            icon,
            style: TextStyle(
              color: const Color(0xFF0A0A0A),
              fontSize: 21,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 3,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: const Color(0xFF0A0A0A),
                        fontSize: 12.25,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),

                    secondIcon,
                  ],
                ),
                Text(
                  desc,
                  style: TextStyle(
                    color: const Color(0xFF717182),
                    fontSize: 10.50,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                if (trailing == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 1.75,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFDCFCE7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.05,
                              color: Colors.black.withValues(alpha: 0),
                            ),
                            borderRadius: BorderRadius.circular(6.75),
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: const Color(0xFF008236),
                            fontSize: 10.50,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          color: const Color(0xFF717182),
                          fontSize: 10.50,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                ?trailing,
                10.ph,
              ],
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

  BadgeItem({
    required this.title,
    required this.desc,
    required this.icon,
    required this.isUnlocked,
  });
}

class RewardItem {
  final String title;
  final String desc;
  final int points;
  final String icon;

  RewardItem({
    required this.title,
    required this.desc,
    required this.points,
    required this.icon,
  });
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
          // padding: const EdgeInsets.symmetric(vertical: 12),
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
                color: isSelected
                    ? Colors.black
                    : Colors.black.withValues(alpha: 0.5),
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
  const _LeaderboardRow({required this.user, required this.rank});

  final LeaderboardUser user;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final initial = user.name.startsWith('You') ? 'Y' : user.name[0];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: user.isCurrentUser
            ? const Color(0x7FEFF6FF)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (rank <= 3) ...[_buildRankIcon(), 6.pw],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: rank % 2 == 1 && rank < 4
                      ? const Color(0xFFFEF3C6)
                      : Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1.05,
                    color: Colors.black.withValues(alpha: 0.10),
                  ),
                ),
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    color: rank % 2 == 1 && rank < 4
                        ? const Color(0xffBB4D00)
                        : const Color(0xFF354152),
                    fontSize: 12,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ),
            ],
          ),
          12.pw,
          CircleAvatar(
            radius: 22,
            backgroundColor: user.isCurrentUser
                ? const Color(0xFFDBEAFE)
                : const Color(0xFFECECF0),
            child: Text(
              initial,
              style: TextStyle(
                color: user.isCurrentUser ? Color(0xff1447E6) : Colors.black54,
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
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto Flex',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
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
                  color: user.isCurrentUser
                      ? const Color(0xFF1447E6)
                      : Colors.black,
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
      return Icon(
        Icons.workspace_premium,
        color: const Color(0xFFD4AF37),
        size: 24,
      );
    }
    if (rank == 2) {
      return Icon(Icons.emoji_events, color: const Color(0xFFC0C0C0), size: 24);
    }
    if (rank == 3) {
      return Icon(
        Icons.military_tech,
        color: const Color(0xFFCD7F32),
        size: 24,
      );
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
        color: badge.isUnlocked
            ? const Color(0xFFF9FAFC)
            : const Color(0xFFF5F5F5),
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
