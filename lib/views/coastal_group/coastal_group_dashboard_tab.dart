import '../../export_all.dart';

class CoastalGroupDashboardTab extends StatelessWidget {
  const CoastalGroupDashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.25;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CoastalGroupHeader(
            sectionTitle: 'Dashboard',
            height: context.screenHeight * 0.30,
            onNotificationTap: () => AppRouter.push(const NotificationView()),
          ),
          Positioned(
            top: contentTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: _FeaturedCleanupCard(context),
                ),
                16.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _StatsGrid(),
                        20.ph,
                        CustomButtonWidget(
                          label: 'Report Waste',
                          onPressed: () {},
                          height: 52,
                        ),
                        24.ph,
                        _UpcomingSection(context),
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

  Widget _FeaturedCleanupCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            child: Image.asset(
              Assets.placeholder,
              fit: BoxFit.cover,
              errorBuilder: (c, e, st) => Center(
                child: Icon(
                  Icons.photo_library,
                  size: 48,
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Image.asset(Assets.bottleOnOceanIcon, width: 28, height: 28),
              10.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ocean Guardians',
                      style: context.robotoFlexBold(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    // 4.ph,
                    Text(
                      'Norcal Coastal Region',
                      style: context.robotoFlexRegular(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(Assets.loyalRankIcon, width: 59, height: 59),
            ],
          ),
        ],
      ),
    );
  }

  Widget _StatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.15,
      padding: EdgeInsets.zero,
      children: [
        _StatCard(
          icon: Assets.trashIcon,
          value: '12,500 kg',
          label: 'Total Waste Collected',
        ),
        _StatCard(
          icon: Assets.environmentImpactIcon,
          value: '10',
          label: 'Active Cleanups',
        ),
        _StatCard(
          icon: Assets.environmentImpactIcon,
          value: '4,250',
          label: 'Eco Points',
        ),
        _StatCard(
          icon: Assets.nextPickupIcon,
          value: 'Saturday',
          label: '10:00 AM',
        ),
      ],
    );
  }

  Widget _UpcomingSection(BuildContext context) {
    const demoCleanups = [
      ('Beach Cleanup in Arcata Bay', 'Arcata Bay, CA', '157', '20 Jun 2025'),
      ('Beach Cleanup in Arcata Bay', 'Arcata Bay, CA', '157', '20 Jun 2025'),
      ('Beach Cleanup in Arcata Bay', 'Arcata Bay, CA', '157', '20 Jun 2025'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Cleanups',
              style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: context.robotoFlexRegular(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
        12.ph,
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: demoCleanups.length,
          itemBuilder: (context, index) {
            final e = demoCleanups[index];
            return _CleanupEventCard(
              title: e.$1,
              location: e.$2,
              members: e.$3,
              date: e.$4,
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final String icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 32,
            height: 32,
            color: AppColors.primaryColor,
          ),
          10.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CleanupEventCard extends StatelessWidget {
  const _CleanupEventCard({
    required this.title,
    required this.location,
    required this.members,
    required this.date,
  });

  final String title;
  final String location;
  final String members;
  final String date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(13),
      child: SizedBox(
        height: 114,
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                Assets.placeholder,
                height: double.infinity,
                width: 114,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: double.infinity,
                  width: 114,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1.ph,
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$location · $members Members',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.66),
                      fontSize: 13,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w300,
                      height: 1.37,
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 4,
                          children: [
                            Image.asset(
                              Assets.communityMemberIcon,
                              width: 18,
                              height: 18,
                              color: Colors.black.withValues(alpha: 0.40),
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.40),
                                fontSize: 13,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w300,
                                height: 1.14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          spacing: 4,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.black.withValues(alpha: 0.40),
                              size: 18,
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.40),
                                fontSize: 13,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w300,
                                height: 1.14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // CustomButtonWidget(
                      //   height: 32,
                      //   label: "Join Event",
                      //   onPressed: (){},
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
