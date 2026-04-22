import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingCourse {
  const TrainingCourse({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.estimatedMinutes,
    required this.ecoPoints,
    required this.videoUrl,
    required this.quiz,
    required this.challenge,
    this.participants = 0,
    this.isActive = true,
  });

  final String id;
  final int order;
  final String title;
  final String description;
  final int estimatedMinutes;
  final int ecoPoints;
  final int participants;
  final bool isActive;

  final String videoUrl;
  final List<TrainingQuizQuestion> quiz;
  final TrainingChallenge challenge;

  factory TrainingCourse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};
    final quizRaw = (data['quiz'] as List<dynamic>?) ?? const [];
    return TrainingCourse(
      id: doc.id,
      order: (data['order'] as num?)?.toInt() ?? 0,
      title: (data['title'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      estimatedMinutes: (data['estimatedMinutes'] as num?)?.toInt() ?? 0,
      ecoPoints: (data['ecoPoints'] as num?)?.toInt() ?? 0,
      participants: (data['participants'] as num?)?.toInt() ?? 0,
      isActive: (data['isActive'] as bool?) ?? true,
      videoUrl: (data['videoUrl'] as String?) ?? '',
      quiz: quizRaw
          .whereType<Map>()
          .map((e) => TrainingQuizQuestion.fromMap(
                Map<String, dynamic>.from(e),
              ))
          .toList(),
      challenge: TrainingChallenge.fromMap(
        Map<String, dynamic>.from((data['challenge'] as Map?) ?? const {}),
      ),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'order': order,
        'title': title,
        'description': description,
        'estimatedMinutes': estimatedMinutes,
        'ecoPoints': ecoPoints,
        'participants': participants,
        'isActive': isActive,
        'videoUrl': videoUrl,
        'quiz': quiz.map((q) => q.toMap()).toList(),
        'challenge': challenge.toMap(),
      };
}

class TrainingQuizQuestion {
  const TrainingQuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;

  factory TrainingQuizQuestion.fromMap(Map<String, dynamic> map) {
    final optionsRaw = (map['options'] as List<dynamic>?) ?? const [];
    return TrainingQuizQuestion(
      id: (map['id'] as String?) ?? '',
      prompt: (map['prompt'] as String?) ?? '',
      options: optionsRaw.map((e) => e.toString()).toList(),
      correctIndex: (map['correctIndex'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'prompt': prompt,
        'options': options,
        'correctIndex': correctIndex,
      };
}

class TrainingChallenge {
  const TrainingChallenge({
    required this.type,
    required this.prompt,
    this.caption,
  });

  final String type;
  final String prompt;
  final String? caption;

  factory TrainingChallenge.fromMap(Map<String, dynamic> map) {
    return TrainingChallenge(
      type: (map['type'] as String?) ?? 'photo',
      prompt: (map['prompt'] as String?) ?? '',
      caption: map['caption'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'type': type,
        'prompt': prompt,
        'caption': caption,
      }..removeWhere((k, v) => v == null);
}
