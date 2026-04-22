import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../models/training/training_course.dart';
import '../../models/training/training_course_progress.dart';
import '../../services/training_course_service.dart';
import '../../utils/colors.dart';
import '../../utils/extension.dart';
import '../../utils/router.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_inner_screen_template.dart';

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
    this.courseId,
    this.courseOrder = 0,
    this.ecoPoints = 0,
    this.estimatedMinutes = 0,
    this.videoUrl = '',
    this.quiz = const [],
    this.challengePrompt = '',
  });

  final String title;
  final String description;
  final String ecoPointsLabel;
  final String lessonMinutesRange;
  final bool hasPracticalChallenge;
  final TrainingModuleStep initialStep;
  final String? challengeCaption;

  /// Firestore `course` document id; `null` = local demo, no [TrainingCourseService] writes.
  final String? courseId;
  final int courseOrder;
  /// Award for [TrainingCourseService.completeCourse] (first completion only).
  final int ecoPoints;
  final int estimatedMinutes;
  final String videoUrl;
  final List<TrainingQuizQuestion> quiz;
  final String challengePrompt;

  static TrainingModuleStep stepFromProgress(TrainingCourseProgress p) {
    if (p.lessonDone != true) return TrainingModuleStep.video;
    if (p.quizBestScore01 < kTrainingQuizPassThreshold) {
      return TrainingModuleStep.quiz;
    }
    if (!p.challengeSubmitted) return TrainingModuleStep.challenge;
    return TrainingModuleStep.video;
  }

  /// Resume step from demo progress fields (no Firestore).
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
      ecoPoints: 0,
      estimatedMinutes: 0,
    );
  }
}

/// Full-screen flow: video → quiz → challenge. Writes progress when [TrainingModuleFlowArgs.courseId] is set.
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

  TrainingModuleFlowArgs get a => widget.args;

  String get _videoHint =>
      a.videoUrl.trim().isNotEmpty
          ? 'Watch the lesson, then continue to the quiz. (${a.lessonMinutesRange} estimated.)'
          : 'Lesson video URL not set — you can still continue. (${a.lessonMinutesRange})';

  TrainingQuizQuestion? get _quizQ =>
      a.quiz.isNotEmpty ? a.quiz.first : null;

  Future<void> _persistVideoDone() async {
    final id = a.courseId;
    if (id == null) return;
    await TrainingCourseService.instance.updateProgress(
      courseId: id,
      lessonDone: true,
      lastStep: 'quiz',
      progress01: 0.34,
    );
  }

  Future<void> _persistQuizPassed() async {
    final id = a.courseId;
    if (id == null) return;
    await TrainingCourseService.instance.updateProgress(
      courseId: id,
      lessonDone: true,
      quizBestScore01: 1.0,
      lastStep: a.hasPracticalChallenge ? 'challenge' : 'quiz',
      progress01: a.hasPracticalChallenge ? 0.67 : 1.0,
    );
  }

  Future<void> _persistChallengeDone() async {
    final id = a.courseId;
    if (id == null) return;
    await TrainingCourseService.instance.updateProgress(
      courseId: id,
      challengeSubmitted: true,
      lastStep: 'challenge',
      progress01: 1.0,
    );
  }

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
          a.courseId != null
              ? 'Progress is saved. Next course unlocks when gating allows.'
              : 'Badge, eco-points and certificate are credited on the server when validation finishes.',
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

  Future<void> _onVideoContinue() async {
    await _persistVideoDone();
    if (!mounted) return;
    setState(() => _videoDone = true);
    _goTo(TrainingModuleStep.quiz);
  }

  Future<void> _onQuizContinue() async {
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
    final q = _quizQ;
    final pass = q == null
        ? _quizSelected == 0
        : _quizSelected == q.correctIndex;
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
    await _persistQuizPassed();
    if (!mounted) return;
    if (a.hasPracticalChallenge) {
      _goTo(TrainingModuleStep.challenge);
    } else {
      final id = a.courseId;
      if (id != null) {
        await TrainingCourseService.instance.completeCourse(
          courseId: id,
          courseOrder: a.courseOrder,
          ecoPoints: a.ecoPoints,
          estimatedMinutes: a.estimatedMinutes,
        );
      }
      await _finishModule();
    }
  }

  Future<void> _onChallengeSubmit() async {
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
    await _persistChallengeDone();
    final id = a.courseId;
    if (id != null) {
      await TrainingCourseService.instance.completeCourse(
        courseId: id,
        courseOrder: a.courseOrder,
        ecoPoints: a.ecoPoints,
        estimatedMinutes: a.estimatedMinutes,
      );
    }
    if (!mounted) return;
    await _finishModule();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerScreenTemplate(
      title: a.title,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _StepDots(current: _step),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: switch (_step) {
                  TrainingModuleStep.video => _VideoStep(
                      videoUrl: a.videoUrl,
                      hint: _videoHint,
                      onContinue: () => unawaited(_onVideoContinue()),
                    ),
                  TrainingModuleStep.quiz => _QuizStep(
                      question: _quizQ,
                      onBack: _videoDone
                          ? () => _goTo(TrainingModuleStep.video)
                          : null,
                      selected: _quizSelected,
                      onSelect: (i) => setState(() => _quizSelected = i),
                      onContinue: () => unawaited(_onQuizContinue()),
                    ),
                  TrainingModuleStep.challenge => _ChallengeStep(
                      prompt: a.challengePrompt.isNotEmpty
                          ? a.challengePrompt
                          : null,
                      caption: a.challengeCaption,
                      submitted: _challengeSubmitted,
                      onPickPhoto: () =>
                          setState(() => _challengeSubmitted = true),
                      onSubmit: () => unawaited(_onChallengeSubmit()),
                      onBack: () => _goTo(TrainingModuleStep.quiz),
                    ),
                },
              ),
            ),
          ],
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

String _formatHms(Duration d) {
  if (d.isNegative) return '00:00';
  final t = d.inSeconds;
  final m = t ~/ 60;
  final s = t % 60;
  return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
}

class _VideoStep extends StatefulWidget {
  const _VideoStep({
    required this.videoUrl,
    required this.hint,
    required this.onContinue,
  });

  final String videoUrl;
  final String hint;
  final VoidCallback onContinue;

  @override
  State<_VideoStep> createState() => _VideoStepState();
}

class _VideoStepState extends State<_VideoStep> {
  VideoPlayerController? _controller;
  bool _loading = true;
  String? _error;
  bool _inFullscreen = false;
  /// While user drags the seek slider, local 0.0–1.0; otherwise null to use [VideoPlayer] position.
  double? _scrubFraction;
  bool _scrubbing = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final url = widget.videoUrl.trim();
    if (url.isEmpty) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'No video URL configured for this course.';
        });
      }
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'Invalid video URL.';
        });
      }
      return;
    }
    final c = VideoPlayerController.networkUrl(
      uri,
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
    );
    _controller = c;
    c.addListener(_onVideoTick);
    try {
      await c.initialize();
    } catch (e) {
      c.removeListener(_onVideoTick);
      await c.dispose();
      _controller = null;
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'Could not load video. ${e.toString()}';
        });
      }
      return;
    }
    if (!mounted) {
      c.dispose();
      _controller = null;
      return;
    }
    if (c.value.hasError) {
      c.removeListener(_onVideoTick);
      c.dispose();
      _controller = null;
      setState(() {
        _loading = false;
        _error = c.value.errorDescription ?? 'Video failed to open.';
      });
      return;
    }
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  void _onVideoTick() {
    if (!mounted || _controller == null) return;
    final v = _controller!.value;
    if (v.hasError) {
      _controller!.removeListener(_onVideoTick);
      _controller!.pause();
      setState(() {
        _error = v.errorDescription ?? 'Playback error.';
      });
      return;
    }
    if (_scrubbing) return;
    setState(() {});
  }

  Future<void> _togglePlay() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    if (c.value.isPlaying) {
      await c.pause();
    } else {
      await c.play();
    }
  }

  double _positionFraction(VideoPlayerValue v) {
    final maxMs = v.duration.inMilliseconds;
    if (maxMs <= 0) return 0;
    return (v.position.inMilliseconds / maxMs).clamp(0.0, 1.0);
  }

  Future<void> _openFullscreen() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    setState(() => _inFullscreen = true);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    if (!mounted) return;
    await Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        opaque: true,
        pageBuilder: (ctx, a, s) => _TrainingFullscreenPlayer(
          controller: c,
          formatHms: _formatHms,
          positionFraction: _positionFraction,
          onClose: () => Navigator.of(ctx).pop(),
        ),
        transitionsBuilder: (ctx, a, s, child) =>
            FadeTransition(opacity: a, child: child),
      ),
    );
    if (mounted) {
      setState(() => _inFullscreen = false);
    }
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  Widget _transportBar(VideoPlayerController c) {
    final v = c.value;
    final maxMs = v.duration.inMilliseconds;
    final displayed = _scrubFraction == null
        ? v.position
        : Duration(
            milliseconds: (_scrubFraction! * maxMs).round().clamp(0, maxMs),
          );
    final sliderValue = _scrubFraction ?? _positionFraction(v);

    return Material(
      color: Colors.transparent,
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.55),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            children: [
              IconButton(
                onPressed: _togglePlay,
                icon: Icon(
                  v.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 26,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    activeTrackColor: const Color(0xFF10B981),
                    inactiveTrackColor: Colors.white24,
                    thumbColor: Colors.white,
                    overlayColor: const Color(0x4010B981),
                  ),
                  child: Slider(
                    value: sliderValue.clamp(0.0, 1.0),
                    onChangeStart: (_) {
                      setState(() {
                        _scrubbing = true;
                        _scrubFraction = _positionFraction(v);
                      });
                    },
                    onChanged: (t) {
                      setState(() => _scrubFraction = t);
                    },
                    onChangeEnd: (t) async {
                      if (maxMs > 0) {
                        final seek = Duration(
                          milliseconds: (t * maxMs).round().clamp(0, maxMs),
                        );
                        await c.seekTo(seek);
                      }
                      if (mounted) {
                        setState(() {
                          _scrubFraction = null;
                          _scrubbing = false;
                        });
                      }
                    },
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 90),
                child: Text(
                  maxMs > 0
                      ? '${_formatHms(displayed)} / ${_formatHms(v.duration)}'
                      : _formatHms(displayed),
                  style: context.robotoFlexRegular(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.95),
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              IconButton(
                onPressed: _openFullscreen,
                icon: Icon(
                  Icons.fullscreen,
                  color: Colors.white.withValues(alpha: 0.95),
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                tooltip: 'Full screen',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Core frame: [VideoPlayer] + center play + tap to play/pause (not on transport).
  Widget _coreFrame(VideoPlayerController c) {
    final v = c.value;
    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: v.size.width,
            height: v.size.height,
            child: VideoPlayer(c),
          ),
        ),
        if (!v.isPlaying)
          ColoredBox(
            color: Colors.black38,
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 64,
                color: Colors.white.withValues(alpha: 0.95),
              ),
            ),
          ),
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _togglePlay,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoTick);
    _controller?.dispose();
    super.dispose();
  }

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
          widget.hint,
          style: context.robotoFlexRegular(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
        20.ph,
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: _buildMainPlayerBlock(),
        ),
        24.ph,
        CustomButtonWidget(
          label: 'Continue to quiz',
          onPressed: widget.onContinue,
          textSize: 16,
          fontWeight: FontWeight.w600,
        ),
        24.ph,
      ],
    );
  }

  Widget _buildMainPlayerBlock() {
    if (_loading) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: Color(0xFF1A332E),
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xFF10B981),
            ),
          ),
        ),
      );
    }
    if (_error != null && _controller == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: const Color(0xFF1A332E),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                _error!,
                textAlign: TextAlign.center,
                style: context.robotoFlexRegular(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
          ),
        ),
      );
    }
    final c = _controller;
    if (c == null || !c.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: const Color(0xFF1A332E),
          child: Center(
            child: Text(
              _error ?? 'Video unavailable',
              textAlign: TextAlign.center,
              style: context.robotoFlexRegular(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ),
      );
    }
    if (c.value.hasError) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: ColoredBox(
          color: const Color(0xFF1A332E),
          child: Center(
            child: Text(
              c.value.errorDescription ?? 'Playback error',
              textAlign: TextAlign.center,
              style: context.robotoFlexRegular(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(
            color: Colors.black,
            child: _inFullscreen
                ? const ColoredBox(color: Colors.black)
                : _coreFrame(c),
          ),
        ),
        if (!_inFullscreen) _transportBar(c),
      ],
    );
  }
}

/// One [VideoPlayer] on this route; inline view hides its player while this is open.
class _TrainingFullscreenPlayer extends StatefulWidget {
  const _TrainingFullscreenPlayer({
    required this.controller,
    required this.formatHms,
    required this.positionFraction,
    required this.onClose,
  });

  final VideoPlayerController controller;
  final String Function(Duration) formatHms;
  final double Function(VideoPlayerValue) positionFraction;
  final VoidCallback onClose;

  @override
  State<_TrainingFullscreenPlayer> createState() =>
      _TrainingFullscreenPlayerState();
}

class _TrainingFullscreenPlayerState extends State<_TrainingFullscreenPlayer> {
  double? _scrubFraction;
  bool _scrubbing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onCtrl);
  }

  void _onCtrl() {
    if (!mounted) return;
    if (_scrubbing) return;
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCtrl);
    super.dispose();
  }

  Future<void> _togglePlay() async {
    final c = widget.controller;
    if (!c.value.isInitialized) return;
    if (c.value.isPlaying) {
      await c.pause();
    } else {
      await c.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    final v = c.value;
    if (v.hasError) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            v.errorDescription ?? 'Error',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    final maxMs = v.duration.inMilliseconds;
    final displayed = _scrubFraction == null
        ? v.position
        : Duration(
            milliseconds: (_scrubFraction! * maxMs).round().clamp(0, maxMs),
          );
    final sliderValue = _scrubFraction ?? widget.positionFraction(v);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: widget.onClose,
                  icon: Icon(
                    Icons.close,
                    color: Colors.white.withValues(alpha: 0.95),
                  ),
                  tooltip: 'Exit full screen',
                ),
                const Spacer(),
              ],
            ),
            Expanded(
              child: ColoredBox(
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SizedBox(
                          width: v.size.width,
                          height: v.size.height,
                          child: VideoPlayer(c),
                        ),
                      ),
                    ),
                    if (!v.isPlaying)
                      ColoredBox(
                        color: Colors.black38,
                        child: Center(
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 72,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: _togglePlay,
                        behavior: HitTestBehavior.translucent,
                        child: const ColoredBox(color: Colors.transparent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.55),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _togglePlay,
                        icon: Icon(
                          v.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 28,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                            activeTrackColor: const Color(0xFF10B981),
                            inactiveTrackColor: Colors.white24,
                            thumbColor: Colors.white,
                            overlayColor: const Color(0x4010B981),
                          ),
                          child: Slider(
                            value: sliderValue.clamp(0.0, 1.0),
                            onChangeStart: (_) {
                              setState(() {
                                _scrubbing = true;
                                _scrubFraction = widget.positionFraction(v);
                              });
                            },
                            onChanged: (t) {
                              setState(() => _scrubFraction = t);
                            },
                            onChangeEnd: (t) async {
                              if (maxMs > 0) {
                                final seek = Duration(
                                  milliseconds: (t * maxMs)
                                      .round()
                                      .clamp(0, maxMs),
                                );
                                await c.seekTo(seek);
                              }
                              if (mounted) {
                                setState(() {
                                  _scrubFraction = null;
                                  _scrubbing = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 90),
                        child: Text(
                          maxMs > 0
                              ? '${widget.formatHms(displayed)} / ${widget.formatHms(v.duration)}'
                              : widget.formatHms(displayed),
                          style: context.robotoFlexRegular(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.95),
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onClose,
                        icon: Icon(
                          Icons.fullscreen_exit,
                          color: Colors.white.withValues(alpha: 0.95),
                          size: 26,
                        ),
                        tooltip: 'Exit full screen',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizStep extends StatelessWidget {
  const _QuizStep({
    required this.onContinue,
    required this.selected,
    required this.onSelect,
    this.onBack,
    this.question,
  });

  final VoidCallback onContinue;
  final int? selected;
  final ValueChanged<int> onSelect;
  final VoidCallback? onBack;
  final TrainingQuizQuestion? question;

  @override
  Widget build(BuildContext context) {
    const demoQuestion =
        'What is the safest first step for used cooking oil at home before collection?';
    final demoOptions = [
      'Cool and store in a closed labeled container.',
      'Pour it down the sink with hot water.',
      'Mix it with regular trash without sealing.',
    ];

    final String qText = question?.prompt ?? demoQuestion;
    final List<String> options =
        question != null && question!.options.isNotEmpty
            ? List<String>.from(question!.options)
            : demoOptions;

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
            qText,
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
    this.prompt,
    required this.onBack,
  });

  final VoidCallback onSubmit;
  final VoidCallback onPickPhoto;
  final bool submitted;
  final String? caption;
  final String? prompt;
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
          if (prompt != null && prompt!.trim().isNotEmpty) ...[
            Text(
              prompt!,
              style: context.robotoFlexMedium(
                fontSize: 14,
                color: const Color(0xFF1A332E),
              ),
            ),
            8.ph,
          ],
          Text(
            caption ??
                'Upload proof for validation when the challenge is a real collection.',
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
