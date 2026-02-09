import '../../../export_all.dart';

enum CourseStatus { completed, inProgress, available, locked }

class _CourseItem {
  final String title;
  final String description;
  final String duration;
  final String points;
  final String participants;
  final CourseStatus status;
  final double progress; // 0 to 1

  const _CourseItem({
    required this.title,
    required this.description,
    required this.duration,
    required this.points,
    required this.participants,
    required this.status,
    this.progress = 0,
  });
}

class TrainerView extends StatelessWidget {
  const TrainerView({super.key});

  static const _courses = [
    _CourseItem(
      title: 'Waste Sorting Basics',
      description: 'Learn the fundamentals of proper waste categorization',
      duration: '15 min',
      points: '100 pts',
      participants: '1250',
      status: CourseStatus.completed,
      progress: 1,
    ),
    _CourseItem(
      title: 'Recycling Best Practices',
      description: 'Advanced techniques for maximizing recycling efficiency',
      duration: '25 min',
      points: '150 pts',
      participants: '890',
      status: CourseStatus.inProgress,
      progress: 0.6,
    ),
    _CourseItem(
      title: 'Composting Guide',
      description: 'Transform organic waste into valuable compost',
      duration: '20 min',
      points: '125 pts',
      participants: '675',
      status: CourseStatus.available,
    ),
    _CourseItem(
      title: 'Hazardous Waste Safety',
      description: 'Safe handling and disposal of dangerous materials',
      duration: '30 min',
      points: '200 pts',
      participants: '432',
      status: CourseStatus.locked,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Text(
                  'Training',
                  textAlign: TextAlign.center,
                  style: context.robotoFlexBold(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _CertificationCard(),
              ),
            ),
            SliverToBoxAdapter(child: 20.ph),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _StatsRow(),
              ),
            ),
            SliverToBoxAdapter(child: 24.ph),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Available Courses',
                  style: context.robotoFlexBold(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: 12.ph),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  child: _CourseCard(course: _courses[index]),
                ),
                childCount: _courses.length,
              ),
            ),
            SliverToBoxAdapter(child: 24.ph),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Training Achievements',
                  style: context.robotoFlexBold(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: 12.ph),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _AchievementCard(
                        title: 'Quick Learner',
                        subtitle: 'First course completed',
                        icon: Icons.emoji_events_rounded,
                        color: const Color(0xFFFFF8E1),
                        iconColor: const Color(0xFFFFB74D),
                      ),
                    ),
                    12.pw,
                    Expanded(
                      child: _AchievementCard(
                        title: 'Knowledge Master',
                        subtitle: 'Complete all courses',
                        icon: Icons.star_rounded,
                        color: Colors.white,
                        iconColor: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: 120.ph),
          ],
        ),
      ),
    );
  }
}

class _CertificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.rewardIcon,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Certification Progress',
                      style: context.robotoFlexMedium(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      '2/4 Completed',
                      style: context.robotoFlexMedium(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.ph,
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.5,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.35),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          12.ph,
          Text(
            'Complete 2 more courses to earn your Waste Management Certificate',
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.white),
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
        Expanded(
          child: _StatCard(
            value: '250',
            label: 'Points Earned',
            iconWidget: Container(
              width: 31.45,
              height: 31.45,

              decoration: ShapeDecoration(
                color: const Color(0xFFFEF9C2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35289400),
                ),
              ),
              child: Icon(
                Icons.star_outline_rounded,
                color: const Color(0xFFD08700),
              ),
            ),
            icon: Icons.star_outline_rounded,
            iconColor: const Color(0xFFD08700),
          ),
        ),
        12.pw,
        Expanded(
          child: _StatCard(
            value: '40',
            label: 'Minutes Spent',
            icon: Icons.schedule_rounded,
            iconColor: Colors.grey.shade700,
          ),
        ),
        12.pw,
        Expanded(
          child: _StatCard(
            value: '50%',
            label: 'Completion',
            icon: Icons.radar_rounded,
            iconColor: Color(0xff10B981),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
    this.iconWidget,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(width: 31, height: 31, child: iconWidget ?? Icon(icon, size: 22, color: iconColor)),
          10.ph,
          Text(
            value,
            style: context.robotoFlexBold(fontSize: 20, color: Colors.black),
          ),
          4.ph,
          Text(
            label,
            style: context.robotoFlexRegular(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final _CourseItem course;

  Color _statusColor() {
    switch (course.status) {
      case CourseStatus.completed:
        return AppColors.primaryColor;
      case CourseStatus.inProgress:
        return const Color(0xFF2196F3);
      case CourseStatus.available:
        return AppColors.primaryColor;
      case CourseStatus.locked:
        return Colors.grey;
    }
  }

  String _statusLabel() {
    switch (course.status) {
      case CourseStatus.completed:
        return 'Completed';
      case CourseStatus.inProgress:
        return 'In Progress';
      case CourseStatus.available:
        return 'Available';
      case CourseStatus.locked:
        return 'Locked';
    }
  }

  Widget _leadingIcon() {
    final color = _statusColor();
    switch (course.status) {
      case CourseStatus.completed:
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_rounded, color: color, size: 26),
        );
      case CourseStatus.inProgress:
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.play_arrow_rounded, color: color, size: 26),
        );
      case CourseStatus.available:
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.menu_book_rounded, color: color, size: 24),
        );
      case CourseStatus.locked:
        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_rounded,
            color: Colors.grey.shade600,
            size: 22,
          ),
        );
    }
  }

  String _buttonLabel() {
    switch (course.status) {
      case CourseStatus.completed:
        return 'Review';
      case CourseStatus.inProgress:
        return 'Continue';
      case CourseStatus.available:
        return 'Start Course';
      case CourseStatus.locked:
        return 'Locked';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();
    final isLocked = course.status == CourseStatus.locked;

    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leadingIcon(),
              14.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: context.robotoFlexBold(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    6.ph,
                    Text(
                      course.description,
                      style: context.robotoFlexRegular(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    10.ph,
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        4.pw,
                        Text(
                          course.duration,
                          style: context.robotoFlexRegular(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        12.pw,
                        Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        4.pw,
                        Text(
                          course.points,
                          style: context.robotoFlexRegular(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        12.pw,
                        Icon(
                          Icons.people_rounded,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        4.pw,
                        Text(
                          course.participants,
                          style: context.robotoFlexRegular(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _statusLabel(),
                        style: context.robotoFlexMedium(
                          fontSize: 11,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (course.status == CourseStatus.completed ||
              course.status == CourseStatus.inProgress) ...[
            12.ph,
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: course.progress,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryColor,
                ),
              ),
            ),
            if (course.status == CourseStatus.completed) 4.ph,
            if (course.status == CourseStatus.completed)
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${(course.progress * 100).toInt()}%',
                  style: context.robotoFlexMedium(
                    fontSize: 11,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
          14.ph,
          SizedBox(
            width: double.infinity,
            child: isLocked
                ? OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: BorderSide(color: Colors.grey.shade300),
                      backgroundColor: const Color(0xFFE0F2F1),
                    ),
                    child: Text(
                      _buttonLabel(),
                      style: context.robotoFlexSemiBold(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )
                : course.status == CourseStatus.completed
                ? OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: const BorderSide(color: AppColors.primaryColor),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      _buttonLabel(),
                      style: context.robotoFlexSemiBold(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      _buttonLabel(),
                      style: context.robotoFlexSemiBold(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: iconColor),
          10.ph,
          Text(
            title,
            style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
          ),
          4.ph,
          Text(
            subtitle,
            style: context.robotoFlexRegular(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
