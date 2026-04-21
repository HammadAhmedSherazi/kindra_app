import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/extension.dart';
import '../../utils/router.dart';
import '../../widget/custom_button_widget.dart';

/// Quiz pass threshold (aligned with Kindra module rules).
const double kTrainingQuizPassThreshold = 0.70;

/// Entry point in the module flow (resume where the user left off).
enum TrainingModuleStep { video, quiz, challenge }

/// Arguments passed into [TrainingModuleFlowView].
class TrainingModuleFlowArgs {
  const TrainingModuleFlowArgs({
    required this.title,
    required this.description,
    required this.ecoPointsLabel,
    required this.lessonMinutesRange,
    required this.hasPracticalChallenge,
    required this.initialStep,
    this.challengeCaption,
  });

  final String title;
  final String description;
  final String ecoPointsLabel;
  final String lessonMinutesRange;
  final bool hasPracticalChallenge;
  final TrainingModuleStep initialStep;
  final String? challengeCaption;

  /// Resume step from demo progress fields.
  factory TrainingModuleFlowArgs.fromModule({
    required String title,
    required String description,
    required String ecoPointsLabel,
    required String lessonMinutesRange,
    required bool hasPracticalChallenge,
    required double lessonProgress01,
    required double quizScore01,
    required double challengeProgress01,
    String? challengeCaption,
  }) {
    TrainingModuleStep step = TrainingModuleStep.video;
    if (lessonProgress01 >= 1.0) {
      if (quizScore01 < kTrainingQuizPassThreshold) {
        step = TrainingModuleStep.quiz;
      } else if (hasPracticalChallenge && challengeProgress01 < 1.0) {
        step = TrainingModuleStep.challenge;
      } else {
        // Fully completed — replay from lesson video.
        step = TrainingModuleStep.video;
      }
    }
    return TrainingModuleFlowArgs(
      title: title,
      description: description,
      ecoPointsLabel: ecoPointsLabel,
      lessonMinutesRange: lessonMinutesRange,
      hasPracticalChallenge: hasPracticalChallenge,
      initialStep: step,
      challengeCaption: challengeCaption,
    );
  }
}

/// Full-screen flow: video lesson → quiz → practical challenge (demo UI).
class TrainingModuleFlowView extends StatefulWidget {
  const TrainingModuleFlowView({super.key, required this.args});

  final TrainingModuleFlowArgs args;

  @override
  State<TrainingModuleFlowView> createState() => _TrainingModuleFlowState();
}

class _TrainingModuleFlowState extends State<TrainingModuleFlowView> {
  late TrainingModuleStep _step;
  int? _quizSelected;
  bool _videoDone = false;
  bool _challengeSubmitted = false;

  @override
  void initState() {
    super.initState();
    _step = widget.args.initialStep;
    if (_step != TrainingModuleStep.video) {
      _videoDone = true;
    }
  }

  void _goTo(TrainingModuleStep s) => setState(() => _step = s);

  Future<void> _finishModule() async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Module complete',
          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
        ),
        content: Text(
          'Badge, eco-points and certificate are credited on the server when validation finishes. Next module unlocks with a notification.',
          style: context.robotoFlexRegular(
            fontSize: 13,
            color: Colors.grey.shade800,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              AppRouter.back();
            },
            child: Text(
              'Done',
              style: context.robotoFlexMedium(
                fontSize: 15,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.args;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => AppRouter.back(),
        ),
        title: Text(
          a.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.robotoFlexBold(fontSize: 17, color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _StepDots(current: _step),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: switch (_step) {
            TrainingModuleStep.video => _VideoStep(
                lessonRange: a.lessonMinutesRange,
                onContinue: () {
                  setState(() => _videoDone = true);
                  _goTo(TrainingModuleStep.quiz);
                },
              ),
            TrainingModuleStep.quiz => _QuizStep(
                onBack: _videoDone
                    ? () => _goTo(TrainingModuleStep.video)
                    : null,
                selected: _quizSelected,
                onSelect: (i) => setState(() => _quizSelected = i),
                onContinue: () {
                  if (_quizSelected == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Choose an answer — you can retry as many times as you need.',
                          style: context.robotoFlexRegular(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color(0xFF1A332E),
                      ),
                    );
                    return;
                  }
                  final pass = _quizSelected == 0;
                  if (!pass) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Not quite — review the lesson and try again. You’ve got this.',
                          style: context.robotoFlexRegular(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color(0xFFB45309),
                      ),
                    );
                    return;
                  }
                  if (a.hasPracticalChallenge) {
                    _goTo(TrainingModuleStep.challenge);
                  } else {
                    _finishModule();
                  }
                },
              ),
            TrainingModuleStep.challenge => _ChallengeStep(
                caption: a.challengeCaption,
                submitted: _challengeSubmitted,
                onPickPhoto: () =>
                    setState(() => _challengeSubmitted = true),
                onSubmit: () {
                  if (!_challengeSubmitted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Add proof for this challenge (or use demo complete).',
                          style: context.robotoFlexRegular(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color(0xFF1A332E),
                      ),
                    );
                    return;
                  }
                  _finishModule();
                },
                onBack: () => _goTo(TrainingModuleStep.quiz),
              ),
          },
        ),
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.current});

  final TrainingModuleStep current;

  static int _stepIndex(TrainingModuleStep s) {
    switch (s) {
      case TrainingModuleStep.video:
        return 0;
      case TrainingModuleStep.quiz:
        return 1;
      case TrainingModuleStep.challenge:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      (TrainingModuleStep.video, 'Video'),
      (TrainingModuleStep.quiz, 'Quiz'),
      (TrainingModuleStep.challenge, 'Challenge'),
    ];
    final cur = _stepIndex(current);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          if (i > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.chevron_right, size: 16, color: Colors.grey.shade400),
            ),
          _Dot(
            label: steps[i].$2,
            active: current == steps[i].$1,
            done: cur > i,
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.label,
    required this.active,
    required this.done,
  });

  final String label;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? AppColors.primaryColor
        : (done ? const Color(0xFF10B981) : Colors.grey.shade400);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: active ? color.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: active ? 1 : 0.5)),
          ),
          child: Text(
            label,
            style: context.robotoFlexMedium(
              fontSize: 11,
              color: active || done ? color : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoStep extends StatelessWidget {
  const _VideoStep({
    required this.lessonRange,
    required this.onContinue,
  });

  final String lessonRange;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Lesson',
          style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
        ),
        8.ph,
        Text(
          'Short video or rich text ($lessonRange). Works on low bandwidth — replace with your hosted stream or offline asset.',
          style: context.robotoFlexRegular(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
        20.ph,
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: ColoredBox(
              color: const Color(0xFF1A332E),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 64,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
          ),
        ),
        24.ph,
        CustomButtonWidget(
          label: 'Continue to quiz',
          onPressed: onContinue,
          textSize: 16,
          fontWeight: FontWeight.w600,
        ),
        24.ph,
      ],
    );
  }
}

class _QuizStep extends StatelessWidget {
  const _QuizStep({
    required this.onContinue,
    required this.selected,
    required this.onSelect,
    this.onBack,
  });

  final VoidCallback onContinue;
  final int? selected;
  final ValueChanged<int> onSelect;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    const question =
        'What is the safest first step for used cooking oil at home before collection?';
    final options = [
      'Cool and store in a closed labeled container.',
      'Pour it down the sink with hot water.',
      'Mix it with regular trash without sealing.',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (onBack != null)
                TextButton.icon(
                  onPressed: onBack,
                  icon: Icon(Icons.arrow_back, size: 18, color: Colors.grey.shade700),
                  label: Text(
                    'Back to video',
                    style: context.robotoFlexMedium(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            'Quiz — need ${(kTrainingQuizPassThreshold * 100).round()}% to continue',
            style: context.robotoFlexBold(fontSize: 16, color: Colors.black),
          ),
          12.ph,
          Text(
            question,
            style: context.robotoFlexRegular(
              fontSize: 14,
              color: Colors.grey.shade800,
            ),
          ),
          16.ph,
          ...List.generate(options.length, (i) {
            final sel = selected == i;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: sel
                    ? AppColors.primaryColor.withValues(alpha: 0.12)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => onSelect(i),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: sel
                            ? AppColors.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          sel ? Icons.radio_button_checked : Icons.radio_button_off,
                          size: 20,
                          color: sel ? AppColors.primaryColor : Colors.grey,
                        ),
                        10.pw,
                        Expanded(
                          child: Text(
                            options[i],
                            style: context.robotoFlexRegular(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          20.ph,
          CustomButtonWidget(
            label: 'Submit answers',
            onPressed: onContinue,
            textSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class _ChallengeStep extends StatelessWidget {
  const _ChallengeStep({
    required this.onSubmit,
    required this.onPickPhoto,
    required this.submitted,
    this.caption,
    required this.onBack,
  });

  final VoidCallback onSubmit;
  final VoidCallback onPickPhoto;
  final bool submitted;
  final String? caption;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton.icon(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back, size: 18, color: Colors.grey.shade700),
            label: Text(
              'Back to quiz',
              style: context.robotoFlexMedium(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Text(
            'Practical challenge',
            style: context.robotoFlexBold(fontSize: 18, color: Colors.black),
          ),
          8.ph,
          Text(
            caption ??
                'Upload proof for AI validation (instant points) or operations review when the challenge is a real collection.',
            style: context.robotoFlexRegular(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
          20.ph,
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.photo_camera_outlined,
                  size: 48,
                  color: Colors.grey.shade600,
                ),
                12.ph,
                Text(
                  submitted
                      ? 'Photo attached (demo)'
                      : 'Tap to attach proof',
                  style: context.robotoFlexMedium(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          16.ph,
          OutlinedButton.icon(
            onPressed: onPickPhoto,
            icon: const Icon(Icons.add_a_photo_outlined),
            label: Text(
              submitted ? 'Replace photo (demo)' : 'Add photo (demo)',
              style: context.robotoFlexMedium(fontSize: 14),
            ),
          ),
          24.ph,
          CustomButtonWidget(
            label: 'Submit challenge',
            onPressed: onSubmit,
            textSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
