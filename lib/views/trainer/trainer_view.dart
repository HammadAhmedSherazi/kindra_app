import '../../../export_all.dart';

enum CourseStatus { completed, inProgress, available, locked }

/// List row model + demo progress for [TrainingModuleFlowArgs] resume.
class _CourseItem {
  const _CourseItem({
    required this.title,
    required this.description,
    required this.duration,
    required this.points,
    required this.participants,
    required this.status,
    this.progress = 0,
    this.lessonProgress01 = 0,
    this.quizScore01 = 0,
    this.challengeProgress01 = 0,
    this.challengeCaption,
  });

  final String title;
  final String description;
  final String duration;
  final String points;
  final String participants;
  final CourseStatus status;
  final double progress;

  final double lessonProgress01;
  final double quizScore01;
  final double challengeProgress01;
  final String? challengeCaption;

  /// Client flow always includes quiz + practical challenge unless backend says otherwise.
  bool get hasPracticalChallenge => true;
}

class TrainerView extends StatelessWidget {
  const TrainerView({super.key});

  static const _fallbackCourses = [
    _CourseItem(
      title: 'Waste Sorting Basics',
      description:
          'Learn the fundamentals of proper waste categorization',
      duration: '15 min',
      points: '100 pts',
      participants: '1250',
      status: CourseStatus.completed,
      progress: 1,
      lessonProgress01: 1,
      quizScore01: 0.85,
      challengeProgress01: 1,
      challengeCaption: 'Photo proof • AI validated',
    ),
    _CourseItem(
      title: 'Recycling Best Practices',
      description:
          'Advanced techniques for maximizing recycling efficiency',
      duration: '25 min',
      points: '150 pts',
      participants: '890',
      status: CourseStatus.inProgress,
      progress: 0.6,
      lessonProgress01: 1,
      quizScore01: 0.55,
      challengeProgress01: 0,
      challengeCaption: 'Upload proof • validation',
    ),
    _CourseItem(
      title: 'Composting Guide',
      description:
          'Transform organic waste into valuable compost',
      duration: '20 min',
      points: '125 pts',
      participants: '675',
      status: CourseStatus.available,
      progress: 0,
      lessonProgress01: 0,
      quizScore01: 0,
      challengeProgress01: 0,
    ),
    _CourseItem(
      title: 'Hazardous Waste Safety',
      description:
          'Safe handling and disposal of dangerous materials',
      duration: '30 min',
      points: '200 pts',
      participants: '432',
      status: CourseStatus.locked,
      progress: 0,
      lessonProgress01: 0,
      quizScore01: 0,
      challengeProgress01: 0,
    ),
    _CourseItem(
      title: 'Used cooking oil at home',
      description:
          'Store, label, and prepare used oil for safe handover — text-first, low data use',
      duration: '12 min',
      points: '110 pts',
      participants: '2100',
      status: CourseStatus.available,
      progress: 0,
      lessonProgress01: 0,
      quizScore01: 0,
      challengeProgress01: 0,
      challengeCaption: 'Photo of sealed container • AI check',
    ),
    _CourseItem(
      title: 'Eco-points & community impact',
      description:
          'How Kindra points, levels, and community ranking connect to real recycling actions',
      duration: '18 min',
      points: '95 pts',
      participants: '1540',
      status: CourseStatus.available,
      progress: 0,
      lessonProgress01: 0,
      quizScore01: 0,
      challengeProgress01: 0,
      challengeCaption: 'Short reflection + optional photo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const courses = TrainerView._fallbackCourses;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Training',
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
                  child: _CourseCard(course: courses[index]),
                ),
                childCount: courses.length,
              ),
            ),
            SliverToBoxAdapter(child: 24.ph),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.50),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                      spreadRadius: -1,
                    ),
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Training Achievements',
                      style: context.robotoFlexMedium(fontSize: 16),
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFEFCE8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.50),
                              ),
                            ),
                            child: Column(
                              spacing: 3,
                              children: [
                                Container(
                                  width: 27.95,
                                  height: 27.95,
                                  padding: EdgeInsets.all(5),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFEF9C2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        35289400,
                                      ),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.rewardIcon,
                                    colorFilter: ColorFilter.mode(
                                      Color(0xffD08700),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Quick Learner',
                                  style: context.robotoFlexMedium(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'First course completed',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: context.robotoFlexRegular(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF9FAFB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.50),
                              ),
                            ),
                            child: Column(
                              spacing: 3,
                              children: [
                                Container(
                                  width: 27.95,
                                  height: 27.95,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.star_outline_rounded,
                                    color: Color(0xff99A1AF),
                                  ),
                                ),
                                Text(
                                  'Knowledge Master',
                                  style: context.robotoFlexMedium(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Complete all courses',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: context.robotoFlexRegular(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                      '2/6 Completed',
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
              value: 2 / 6,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.35),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          12.ph,
          Text(
            'Complete 4 more courses to earn your Waste Management Certificate',
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
          SizedBox(
            width: 31,
            height: 31,
            child: iconWidget ?? Icon(icon, size: 22, color: iconColor),
          ),
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
        return ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: Image.asset(Assets.checkedIcon, width: 15, height: 15),
        );
      case CourseStatus.inProgress:
        return SvgPicture.asset(Assets.playIcon, width: 15, height: 15);
      case CourseStatus.available:
        return SvgPicture.asset(Assets.readIcon, width: 15, height: 15);
      case CourseStatus.locked:
        return SvgPicture.asset(Assets.lockIcon, width: 15, height: 15);
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

  Future<void> _openStartFlow(BuildContext context) async {
    await _presentTrainingCourseFlow(
      context,
      course,
      isReplay: course.status == CourseStatus.completed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();
    final isLocked = course.status == CourseStatus.locked;
    final progressPct = (course.progress.clamp(0.0, 1.0) * 100).round();

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Column(children: [10.ph, _leadingIcon()]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        course.title,
                        style: context.robotoFlexRegular(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                      Icons.star_outline_rounded,
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
                      Icons.people_outline_rounded,
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
                if (course.status == CourseStatus.completed ||
                    course.status == CourseStatus.inProgress) ...[
                  10.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          color: const Color(0xFF1A332E),
                          fontSize: 10.50,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                      Text(
                        '$progressPct%',
                        style: TextStyle(
                          color: const Color(0xFF1A332E),
                          fontSize: 10.50,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                  8.ph,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: course.progress.clamp(0.0, 1.0),
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xff10B981),
                      ),
                    ),
                  ),
                  if (course.status == CourseStatus.completed) ...[
                    4.ph,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$progressPct%',
                        style: context.robotoFlexMedium(
                          fontSize: 11,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ],
                14.ph,
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: isLocked
                      ? Opacity(
                          opacity: 0.50,
                          child: OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              foregroundColor: Colors.grey,
                              side: BorderSide(color: Colors.grey.shade300),
                              backgroundColor: const Color(0xFF10B981),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.50),
                              ),
                            ),
                            child: Text(
                              _buttonLabel(),
                              style: context.robotoFlexMedium(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : course.status == CourseStatus.completed
                          ? OutlinedButton(
                              onPressed: () => _openStartFlow(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFFF8FFFE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.50),
                                ),
                                side: BorderSide(
                                  width: 1.05,
                                  color: const Color(0x2610B981),
                                ),
                                backgroundColor: const Color(0xFFF8FFFE),
                              ),
                              child: Text(
                                _buttonLabel(),
                                style: context.robotoFlexMedium(fontSize: 14),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () => _openStartFlow(context),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.50),
                                ),
                                backgroundColor: Color(0xff10B981),
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                _buttonLabel(),
                                style: context.robotoFlexMedium(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
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

/// Intro dialog → [TrainingModuleFlowView] (video → quiz → challenge).
Future<void> _presentTrainingCourseFlow(
  BuildContext context,
  _CourseItem course, {
  required bool isReplay,
}) async {
  final passPct = (kTrainingQuizPassThreshold * 100).round();
  final proceed = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => AlertDialog(
      title: Text(
        course.title,
        style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              course.description,
              style: context.robotoFlexRegular(
                fontSize: 13,
                color: Colors.grey.shade800,
              ),
            ),
            14.ph,
            Text(
              'After you start',
              style: context.robotoFlexBold(fontSize: 14, color: Colors.black),
            ),
            8.ph,
            Text(
              '• Video lesson (${course.duration})\n'
              '• Quiz — $passPct%+ to continue\n'
              '${course.hasPracticalChallenge ? '• Practical challenge\n' : ''}'
              '• Points: ${course.points}',
              style: context.robotoFlexRegular(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
            if (course.challengeCaption != null) ...[
              10.ph,
              Text(
                course.challengeCaption!,
                style: context.robotoFlexMedium(
                  fontSize: 11,
                  color: const Color(0xFF1A332E),
                ),
              ),
            ],
            if (isReplay) ...[
              12.ph,
              Text(
                'Completed course — replay from the video if you want to review.',
                style: context.robotoFlexRegular(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(
            'Cancel',
            style: context.robotoFlexMedium(
              fontSize: 15,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff10B981),
            foregroundColor: Colors.white,
          ),
          child: Text(
            isReplay ? 'Replay' : 'Start',
            style: context.robotoFlexMedium(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    ),
  );

  if (proceed != true || !context.mounted) return;

  final args = TrainingModuleFlowArgs.fromModule(
    title: course.title,
    description: course.description,
    ecoPointsLabel: course.points,
    lessonMinutesRange: course.duration,
    hasPracticalChallenge: course.hasPracticalChallenge,
    lessonProgress01: course.lessonProgress01,
    quizScore01: course.quizScore01,
    challengeProgress01: course.challengeProgress01,
    challengeCaption: course.challengeCaption,
  );

  await AppRouter.push(TrainingModuleFlowView(args: args));
}
