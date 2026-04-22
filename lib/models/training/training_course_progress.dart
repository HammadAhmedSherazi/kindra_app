import 'package:cloud_firestore/cloud_firestore.dart';

enum TrainingCourseStatus { notStarted, inProgress, completed }

class TrainingCourseProgress {
  const TrainingCourseProgress({
    required this.courseId,
    required this.status,
    required this.progress01,
    required this.lessonDone,
    required this.quizBestScore01,
    required this.challengeSubmitted,
    required this.lastStep,
    required this.updatedAt,
    this.assignedAt,
    this.completedAt,
    this.quizAttempts,
    this.lastSelectedAnswerIndex,
  });

  final String courseId;
  final TrainingCourseStatus status;
  final double progress01;
  final bool lessonDone;
  final double quizBestScore01;
  final bool challengeSubmitted;
  final String lastStep;
  final DateTime updatedAt;
  final DateTime? assignedAt;
  final DateTime? completedAt;
  final int? quizAttempts;
  final int? lastSelectedAnswerIndex;

  factory TrainingCourseProgress.empty(String courseId) {
    return TrainingCourseProgress(
      courseId: courseId,
      status: TrainingCourseStatus.notStarted,
      progress01: 0,
      lessonDone: false,
      quizBestScore01: 0,
      challengeSubmitted: false,
      lastStep: 'video',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory TrainingCourseProgress.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};
    final statusRaw = (data['status'] as String?) ?? 'notStarted';
    DateTime? tsToDt(dynamic v) {
      if (v is Timestamp) return v.toDate();
      if (v is DateTime) return v;
      return null;
    }

    return TrainingCourseProgress(
      courseId: (data['courseId'] as String?) ?? doc.id,
      status: TrainingCourseStatus.values.firstWhere(
        (e) => e.name == statusRaw,
        orElse: () => TrainingCourseStatus.notStarted,
      ),
      progress01: ((data['progress01'] as num?)?.toDouble() ?? 0).clamp(0, 1),
      lessonDone: (data['lessonDone'] as bool?) ?? false,
      quizBestScore01:
          ((data['quizBestScore01'] as num?)?.toDouble() ?? 0).clamp(0, 1),
      challengeSubmitted: (data['challengeSubmitted'] as bool?) ?? false,
      lastStep: (data['lastStep'] as String?) ?? 'video',
      updatedAt: tsToDt(data['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      assignedAt: tsToDt(data['assignedAt']),
      completedAt: tsToDt(data['completedAt']),
      quizAttempts: (data['quizAttempts'] as num?)?.toInt(),
      lastSelectedAnswerIndex: (data['lastSelectedAnswerIndex'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'courseId': courseId,
        'status': status.name,
        'progress01': progress01,
        'lessonDone': lessonDone,
        'quizBestScore01': quizBestScore01,
        'challengeSubmitted': challengeSubmitted,
        'lastStep': lastStep,
        'updatedAt': Timestamp.fromDate(updatedAt),
        'assignedAt': assignedAt == null ? null : Timestamp.fromDate(assignedAt!),
        'completedAt':
            completedAt == null ? null : Timestamp.fromDate(completedAt!),
        'quizAttempts': quizAttempts,
        'lastSelectedAnswerIndex': lastSelectedAnswerIndex,
      }..removeWhere((k, v) => v == null);
}
