import '../../../export_all.dart';

/// Lists documents from Firestore [TrainingCourseService.coursesCollection] (`course`).
class TrainerView extends ConsumerWidget {
  const TrainerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(currentUserBaseProvider).maybeWhen(
          data: (u) => u?.role,
          orElse: () => null,
        );
    final isHouseholder = role == LoginUserRole.householder;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Training',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: TrainingCourseService.instance.seedDemoCoursesIfEmpty(),
                builder: (context, seedSnap) {
                  if (seedSnap.hasError) {
                    // Seed is best-effort; still show course list below.
                  }
                  return StreamBuilder<List<TrainingCourse>>(
                    stream: TrainingCourseService.instance.watchCourses(),
                    builder: (context, coursesSnap) {
                      final coursesFb =
                          coursesSnap.data ?? const <TrainingCourse>[];
                      return StreamBuilder<
                          ({String? activeCourseId, int unlockedUpToOrder})>(
                        stream:
                            TrainingCourseService.instance.watchMyTrainingGate(),
                        builder: (context, gateSnap) {
                          final gate = gateSnap.data ??
                              (activeCourseId: null, unlockedUpToOrder: 0);
                          return StreamBuilder<
                              Map<String, TrainingCourseProgress>>(
                            stream:
                                TrainingCourseService.instance.watchMyProgress(),
                            builder: (context, progressSnap) {
                              final progressMap = progressSnap.data ??
                                  const <String, TrainingCourseProgress>{};

                              final err = coursesSnap.hasError
                                  ? coursesSnap.error
                                  : gateSnap.hasError
                                      ? gateSnap.error
                                      : progressSnap.hasError
                                          ? progressSnap.error
                                          : null;
                              if (err != null) {
                                return Center(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(24),
                                    child: Text(
                                      'Could not load training data.\n\n'
                                      '${err.toString()}\n\n'
                                      'Check: collection name is "course" in the same '
                                      'Firebase project as the app, Firestore rules, '
                                      'and that you are signed in.',
                                      textAlign: TextAlign.start,
                                      style: context.robotoFlexRegular(
                                        fontSize: 13,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final items = buildTrainingCourseListItems(
                                courses: coursesFb,
                                progressMap: progressMap,
                                activeCourseId: gate.activeCourseId,
                                unlockedUpToOrder: gate.unlockedUpToOrder,
                                isHouseholder: isHouseholder,
                              );

                              return CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: _CertificationCard(
                                        total: items.length,
                                        completed: items
                                            .where(
                                              (e) =>
                                                  e.status ==
                                                  TrainingCourseListStatus
                                                      .completed,
                                            )
                                            .length,
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(child: 20.ph),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: StreamBuilder<
                                          ({
                                            int pointsEarned,
                                            int minutesSpent,
                                          })>(
                                        stream: TrainingCourseService.instance
                                            .watchTrainingStats(),
                                        builder: (context, statSnap) {
                                          final stat = statSnap.data ??
                                              (
                                                pointsEarned: 0,
                                                minutesSpent: 0,
                                              );
                                          final completedN = items
                                              .where(
                                                (e) =>
                                                    e.status ==
                                                    TrainingCourseListStatus
                                                        .completed,
                                              )
                                              .length;
                                          final totalN = items.isEmpty
                                              ? 1
                                              : items.length;
                                          final completionPct = ((completedN *
                                                      100) /
                                                  totalN)
                                              .round()
                                              .clamp(0, 100);
                                          return _StatsRow(
                                            pointsEarned: stat.pointsEarned,
                                            minutesSpent: stat.minutesSpent,
                                            completionPercent: completionPct,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(child: 24.ph),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
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
                                  if (items.isEmpty)
                                    SliverToBoxAdapter(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 32,
                                        ),
                                        child: Text(
                                          coursesSnap.connectionState ==
                                                  ConnectionState.waiting
                                              ? 'Loading courses…'
                                              : 'No active courses. Upload from JSON or add documents in the `course` collection.',
                                          style: context.robotoFlexRegular(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 6,
                                          ),
                                          child: TrainingCourseCard(
                                            course: items[index],
                                          ),
                                        ),
                                        childCount: items.length,
                                      ),
                                    ),
                                  SliverToBoxAdapter(child: 24.ph),
                                  SliverToBoxAdapter(
                                    child: _TrainingAchievementsCard(),
                                  ),
                                  SliverToBoxAdapter(child: 120.ph),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingAchievementsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.50),
        ),
        shadows: const [
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
                  padding: const EdgeInsets.all(20),
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
                        padding: const EdgeInsets.all(5),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFEF9C2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35289400),
                          ),
                        ),
                        child: SvgPicture.asset(
                          Assets.rewardIcon,
                          colorFilter: const ColorFilter.mode(
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
                  padding: const EdgeInsets.all(20),
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
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F4F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
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
    );
  }
}

class _CertificationCard extends StatelessWidget {
  const _CertificationCard({
    required this.total,
    required this.completed,
  });

  final int total;
  final int completed;

  @override
  Widget build(BuildContext context) {
    final t = total <= 0 ? 1 : total;
    final c = completed.clamp(0, t);
    final progress = c / t;
    final remain = (t - c).clamp(0, t);

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
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
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
                      '$c/$t Completed',
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
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.35),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          12.ph,
          Text(
            remain <= 0
                ? 'You have completed the current course set.'
                : 'Complete $remain more course${remain == 1 ? '' : 's'} to earn your Waste Management Certificate',
            style: context.robotoFlexRegular(fontSize: 13, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.pointsEarned,
    required this.minutesSpent,
    required this.completionPercent,
  });

  final int pointsEarned;
  final int minutesSpent;
  final int completionPercent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: _formatInt(pointsEarned),
            label: 'Points Earned',
            iconWidget: const _StatIconStar(),
            icon: Icons.star_outline_rounded,
            iconColor: const Color(0xFFD08700),
          ),
        ),
        12.pw,
        Expanded(
          child: _StatCard(
            value: _formatInt(minutesSpent),
            label: 'Minutes Spent',
            icon: Icons.schedule_rounded,
            iconColor: Colors.grey.shade700,
          ),
        ),
        12.pw,
        Expanded(
          child: _StatCard(
            value: '$completionPercent%',
            label: 'Completion',
            icon: Icons.radar_rounded,
            iconColor: const Color(0xff10B981),
          ),
        ),
      ],
    );
  }

  String _formatInt(int n) {
    if (n < 1000) return '$n';
    if (n < 1000000) {
      final s = (n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1);
      return '${s}k';
    }
    return '${(n / 1000000).toStringAsFixed(1)}M';
  }
}

class _StatIconStar extends StatelessWidget {
  const _StatIconStar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31.45,
      height: 31.45,
      decoration: ShapeDecoration(
        color: const Color(0xFFFEF9C2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35289400),
        ),
      ),
      child: const Icon(
        Icons.star_outline_rounded,
        color: Color(0xFFD08700),
      ),
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
