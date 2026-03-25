import '../../export_all.dart';

/// Shown when user has joined an event. Shows participation confirmation, tasks, team, announcement.
class JoinedEventDetailView extends ConsumerStatefulWidget {
  const JoinedEventDetailView({
    super.key,
    required this.event,
  });

  final CleanupEventItem event;

  @override
  ConsumerState<JoinedEventDetailView> createState() =>
      _JoinedEventDetailViewState();
}

class _JoinedEventDetailViewState extends ConsumerState<JoinedEventDetailView> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.screenWidth * 0.05;
    final headerHeight = context.screenHeight * 0.30;
    final contentTop = communityDashboardStackContentTop(
      context,
      screenHeightFraction: 0.24,
      coastalHeaderLayout: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CoastalGroupHeader(
              sectionTitle: 'Upcoming Cleanups',
              height: headerHeight,
              onNotificationTap: () => AppRouter.push(const NotificationView()),
              // leading: GestureDetector(
              //   onTap: () => AppRouter.back(),
              //   child: const Padding(
              //     padding: EdgeInsets.only(top: 4),
              //     child: Icon(
              //       Icons.arrow_back_ios,
              //       color: Colors.white,
              //       size: 22,
              //     ),
              //   ),
              // ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  'Joined',
                  style: context.robotoFlexSemiBold(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
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
                    child: _buildParticipatingCard(),
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
                          Text(
                            'Sunday, April 28 | 10:00 AM - 1:00 PM',
                            style: context.robotoFlexMedium(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          16.ph,
                          _buildVolunteerTasksCard(),
                          16.ph,
                          _buildMyTeamCard(context),
                          16.ph,
                          _buildAnnouncementCard(),
                          24.ph,
                          CustomButtonWidget(
                            label: 'Message Team',
                            onPressed: () => AppRouter.push(
                              SendMessageView(event: widget.event),
                            ),
                            height: 52,
                          ),
                          12.ph,
                          CustomButtonWidget(
                            label: 'Mark Attendance',
                            onPressed: () => AppRouter.push(
                              EventCheckinView(event: widget.event),
                            ),
                            backgroundColor: const Color(0xff414141),
                            height: 52,
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
      ),
    );
  }

  Widget _buildParticipatingCard() {
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
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                Assets.checkBlackIcon,
                width: 28,
                height: 28,
                color: Colors.white,
              ),
            ),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You are participating!',
                  style: context.robotoFlexBold(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                4.ph,
                Text(
                  'You have successfully Joined This event.',
                  style: context.robotoFlexRegular(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolunteerTasksCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Volunteer Tasks',
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          12.ph,
          Text(
            'Meet our group "Ocean Guardians" at 10:00 AM to check in and get instructions.',
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          12.ph,
          _bullet('Vests, gloves, bags will be provided.'),
          6.ph,
          _bullet('Wear sturdy shoes and bring water!'),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              shape: BoxShape.circle,
            ),
          ),
        ),
        10.pw,
        Expanded(
          child: Text(
            text,
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyTeamCard(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Team',
                style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See All',
                  style: context.robotoFlexSemiBold(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          16.ph,
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
                          child: Text(
                            'S',
                            style: context.robotoFlexBold(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        12.pw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sam',
                                style: context.robotoFlexSemiBold(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Team leader',
                                style: context.robotoFlexRegular(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.pw,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _smallAvatar('A'),
                  _smallAvatar('B'),
                  _smallAvatar('C'),
                  const SizedBox(width: 4),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '+22',
                        style: context.robotoFlexSemiBold(
                          fontSize: 11,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallAvatar(String letter) {
    return Transform.translate(
      offset: const Offset(-8, 0),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Center(
          child: Text(
            letter,
            style: context.robotoFlexSemiBold(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Announcement',
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          12.ph,
          Text(
            'Please remember to bring plenty of water. Looking forward to seeing all of you there!',
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
