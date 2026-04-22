import 'dart:async' show unawaited;

import '../export_all.dart';

class TrainingCourseCard extends StatelessWidget {
  const TrainingCourseCard({super.key, required this.course});

  final TrainingCourseListItem course;

  Color _statusColor() {
    switch (course.status) {
      case TrainingCourseListStatus.completed:
        return AppColors.primaryColor;
      case TrainingCourseListStatus.inProgress:
        return const Color(0xFF2196F3);
      case TrainingCourseListStatus.available:
        return AppColors.primaryColor;
      case TrainingCourseListStatus.locked:
        return Colors.grey;
    }
  }

  String _statusLabel() {
    switch (course.status) {
      case TrainingCourseListStatus.completed:
        return 'Completed';
      case TrainingCourseListStatus.inProgress:
        return 'In Progress';
      case TrainingCourseListStatus.available:
        return 'Available';
      case TrainingCourseListStatus.locked:
        return 'Locked';
    }
  }

  Widget _leadingIcon() {
    final color = _statusColor();
    switch (course.status) {
      case TrainingCourseListStatus.completed:
        return ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: Image.asset(Assets.checkedIcon, width: 15, height: 15),
        );
      case TrainingCourseListStatus.inProgress:
        return SvgPicture.asset(Assets.playIcon, width: 15, height: 15);
      case TrainingCourseListStatus.available:
        return SvgPicture.asset(Assets.readIcon, width: 15, height: 15);
      case TrainingCourseListStatus.locked:
        return SvgPicture.asset(Assets.lockIcon, width: 15, height: 15);
    }
  }

  String _buttonLabel() {
    switch (course.status) {
      case TrainingCourseListStatus.completed:
        return 'Review';
      case TrainingCourseListStatus.inProgress:
        return 'Continue';
      case TrainingCourseListStatus.available:
        return 'Start Course';
      case TrainingCourseListStatus.locked:
        return 'Locked';
    }
  }

  TrainingModuleStep _initialStep() {
    switch (course.status) {
      case TrainingCourseListStatus.available:
        return TrainingModuleStep.video;
      case TrainingCourseListStatus.inProgress:
        final p = course.progressRecord;
        if (p == null) return TrainingModuleStep.video;
        return TrainingModuleFlowArgs.stepFromProgress(p);
      case TrainingCourseListStatus.completed:
        return TrainingModuleStep.video;
      case TrainingCourseListStatus.locked:
        return TrainingModuleStep.video;
    }
  }

  Future<void> _openStartFlow(BuildContext context) async {
    if (course.status == TrainingCourseListStatus.locked) return;

    if (course.status == TrainingCourseListStatus.available) {
      final go = await _showStartOrReplayDialog(
        context,
        isReplay: false,
      );
      if (go != true || !context.mounted) return;
      await TrainingCourseService.instance.startCourse(
        courseId: course.id,
        courseOrder: course.order,
      );
    } else if (course.status == TrainingCourseListStatus.completed) {
      final go = await _showStartOrReplayDialog(
        context,
        isReplay: true,
      );
      if (go != true || !context.mounted) return;
    }

    final initialStep = _initialStep();

    if (!context.mounted) return;
    await AppRouter.push(
      TrainingModuleFlowView(
        args: TrainingModuleFlowArgs(
          courseId: course.id,
          courseOrder: course.order,
          title: course.title,
          description: course.description,
          ecoPointsLabel: '${course.ecoPoints} pts',
          lessonMinutesRange: '${course.estimatedMinutes} min',
          ecoPoints: course.ecoPoints,
          estimatedMinutes: course.estimatedMinutes,
          hasPracticalChallenge: true,
          videoUrl: course.videoUrl,
          quiz: course.quiz,
          challengePrompt: course.challengePrompt,
          challengeCaption: course.challengeCaption,
          initialStep: initialStep,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();
    final isLocked = course.status == TrainingCourseListStatus.locked;
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
                      '${course.estimatedMinutes} min',
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
                      '${course.ecoPoints} pts',
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
                      '${course.participants}',
                      style: context.robotoFlexRegular(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                if (course.status == TrainingCourseListStatus.completed ||
                    course.status == TrainingCourseListStatus.inProgress) ...[
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
                  if (course.status == TrainingCourseListStatus.completed) ...[
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
                      : course.status == TrainingCourseListStatus.completed
                          ? OutlinedButton(
                              onPressed: () => unawaited(
                                _openStartFlow(context),
                              ),
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
                              onPressed: () => unawaited(
                                _openStartFlow(context),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.50),
                                ),
                                backgroundColor: const Color(0xff10B981),
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

  Future<bool?> _showStartOrReplayDialog(
    BuildContext context, {
    required bool isReplay,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          course.title,
          style: ctx.robotoFlexBold(fontSize: 18, color: Colors.black),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (course.description.isNotEmpty)
                Text(
                  course.description,
                  style: ctx.robotoFlexRegular(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              12.ph,
              Text(
                'What to expect',
                style: ctx.robotoFlexMedium(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              6.ph,
              _trainingDialogBullet(
                ctx,
                'Watch the lesson video (about ${course.estimatedMinutes} min)',
              ),
              _trainingDialogBullet(
                ctx,
                'Pass the quiz — at least ${(kTrainingQuizPassThreshold * 100).round()}% to continue',
              ),
              if (course.challengePrompt.isNotEmpty) ...[
                _trainingDialogBullet(
                  ctx,
                  course.challengeCaption != null &&
                          course.challengeCaption!.isNotEmpty
                      ? 'Challenge: ${course.challengeCaption!}'
                      : 'Complete the practical photo challenge to finish the module',
                ),
              ],
              8.ph,
              Text(
                'Rewards: ${course.ecoPoints} eco-points on completion',
                style: ctx.robotoFlexRegular(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: ctx.robotoFlexMedium(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              isReplay ? 'Replay' : 'Start',
              style: ctx.robotoFlexMedium(
                fontSize: 15,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _trainingDialogBullet(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: context.robotoFlexRegular(
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}
