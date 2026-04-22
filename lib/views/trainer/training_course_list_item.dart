import '../../models/training/training_course.dart';
import '../../models/training/training_course_progress.dart';

enum TrainingCourseListStatus { completed, inProgress, available, locked }

class TrainingCourseListItem {
  const TrainingCourseListItem({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.estimatedMinutes,
    required this.ecoPoints,
    required this.participants,
    required this.videoUrl,
    required this.quiz,
    required this.challengePrompt,
    required this.status,
    required this.progress,
    this.challengeCaption,
    this.progressRecord,
  });

  final String id;
  final int order;
  final String title;
  final String description;
  final int estimatedMinutes;
  final int ecoPoints;
  final int participants;
  final String videoUrl;
  final List<TrainingQuizQuestion> quiz;
  final String challengePrompt;
  final TrainingCourseListStatus status;
  final double progress;
  final String? challengeCaption;
  final TrainingCourseProgress? progressRecord;
}

List<TrainingCourseListItem> buildTrainingCourseListItems({
  required List<TrainingCourse> courses,
  required Map<String, TrainingCourseProgress> progressMap,
  required String? activeCourseId,
  required int unlockedUpToOrder,
  required bool isHouseholder,
}) {
  return courses.map((c) {
    final p = progressMap[c.id] ?? TrainingCourseProgress.empty(c.id);

    final lockedByOrder = isHouseholder && c.order > unlockedUpToOrder;
    final lockedByActive = isHouseholder &&
        activeCourseId != null &&
        activeCourseId.isNotEmpty &&
        activeCourseId != c.id;
    final isLocked = lockedByOrder || lockedByActive;

    final status = p.status == TrainingCourseStatus.completed
        ? TrainingCourseListStatus.completed
        : (p.status == TrainingCourseStatus.inProgress || activeCourseId == c.id)
            ? TrainingCourseListStatus.inProgress
            : (isLocked
                ? TrainingCourseListStatus.locked
                : TrainingCourseListStatus.available);

    return TrainingCourseListItem(
      id: c.id,
      order: c.order,
      title: c.title,
      description: c.description,
      estimatedMinutes: c.estimatedMinutes,
      ecoPoints: c.ecoPoints,
      participants: c.participants,
      videoUrl: c.videoUrl,
      quiz: c.quiz,
      challengePrompt: c.challenge.prompt,
      status: status,
      progress: p.progress01,
      challengeCaption: c.challenge.caption,
      progressRecord: p,
    );
  }).toList();
}
