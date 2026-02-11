import '../../export_all.dart';

class CommunityMemberTab extends ConsumerStatefulWidget {
  const CommunityMemberTab({super.key});

  @override
  ConsumerState<CommunityMemberTab> createState() => _CommunityMemberTabState();
}

class _CommunityMemberTabState extends ConsumerState<CommunityMemberTab> {
  bool _activeOnly = true;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final contentTop = context.screenHeight * 0.23;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CommunityDashboardHeader(
            sectionTitle: 'Members Overview',
            onLogout: () {},
          ),
          Positioned(
            top: contentTop,
            left: horizontalPadding,
            right: horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSummaryCard(context),
                Container(
                  height: context.screenHeight * 0.78,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    // spacing: 20,
                    children: [
                      20.ph,
                      _buildActiveInactiveToggle(context),
                      20.ph,
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero.copyWith(bottom: 200),
                          itemBuilder: (context, index) => _buildMemberCard(
                            'Smith Family',
                            '200 liters Achieved',
                            true,
                          ),
                          separatorBuilder: (context, index) => 10.ph,
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            Assets.communityMemberIcon,
            width: 40,
            height: 40,
            color: AppColors.primaryColor,
          ),
          16.pw,
          Text(
            '38 Community Members',
            style: context.robotoFlexSemiBold(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveInactiveToggle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _activeOnly = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: _activeOnly
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Active',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _activeOnly ? Colors.white : Colors.grey.shade700,
                  fontSize: 15,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        12.pw,
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _activeOnly = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: !_activeOnly
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Inactive',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: !_activeOnly ? Colors.white : Colors.grey.shade700,
                  fontSize: 15,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemberCard(String name, String achieved, bool active) {
    return GestureDetector(
      onTap: () => AppRouter.push(const MemberDetailView()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.robotoFlexSemiBold(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  4.ph,
                  Text(
                    achieved,
                    style: context.robotoFlexRegular(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: active ? AppColors.primaryColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                active ? 'Active' : 'Inactive',
                style: TextStyle(
                  color: active ? Colors.white : Colors.grey.shade700,
                  fontSize: 12,
                  fontFamily: 'Roboto Flex',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
