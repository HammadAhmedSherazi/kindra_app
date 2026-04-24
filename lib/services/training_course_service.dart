import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/training/training_course.dart';
import '../models/training/training_course_progress.dart';
import 'firebase_auth_service.dart';

class TrainingCourseService {
  TrainingCourseService._();

  static final TrainingCourseService instance = TrainingCourseService._();

  final _firestore = FirebaseFirestore.instance;

  static const String coursesCollection = 'course';
  static const String userProgressSubcollection = 'trainingProgress';

  /// Aggregated points/minutes; separate doc so `users/{uid}` rules (field allowlists) do
  /// not block [FieldValue.increment] on a top-level field. Path: `appTraining/summary`.
  static const String _appTrainingSubcollection = 'appTraining';
  static const String _appTrainingStatsDocId = 'summary';

  DocumentReference<Map<String, dynamic>> _trainingStatsDoc(String uid) =>
      _userDoc(uid)
          .collection(_appTrainingSubcollection)
          .doc(_appTrainingStatsDocId);

  static const String _defaultCoursesAsset = 'assets/training/training_courses.json';

  static const bool kPushTrainingJsonToFirestore = false;

  Future<void> uploadAllCoursesFromAsset() async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw StateError('Sign in to upload courses to Firestore.');
    }
    final raw = await rootBundle.loadString(_defaultCoursesAsset);
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final rawCourses = decoded['courses'];
    final list = <Map<String, dynamic>>[];
    if (rawCourses is List) {
      for (final e in rawCourses) {
        if (e is Map) list.add(Map<String, dynamic>.from(e));
      }
    } else if (rawCourses is Map<String, dynamic>) {
      for (final entry in rawCourses.entries) {
        list.add(Map<String, dynamic>.from(entry.value as Map));
      }
    }
    if (list.isEmpty) {
      throw StateError('No "courses" array (or non-empty map) in $_defaultCoursesAsset');
    }

    const int maxPerBatch = 500;
    for (var i = 0; i < list.length; i += maxPerBatch) {
      final end = (i + maxPerBatch > list.length) ? list.length : i + maxPerBatch;
      final batch = _firestore.batch();
      for (var j = i; j < end; j++) {
        final data = Map<String, dynamic>.from(list[j]);
        data.remove('id');
        data.removeWhere((k, v) => v == null);
        final ref = _coursesCol().doc();
        batch.set(ref, data);
      }
      await batch.commit();
    }
  }

  String get _uid {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) throw StateError('No logged-in user');
    return uid;
  }

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _firestore.collection(FirebaseAuthService.usersCollection).doc(uid);

  CollectionReference<Map<String, dynamic>> _coursesCol() =>
      _firestore.collection(coursesCollection);

  DocumentReference<Map<String, dynamic>> _progressDoc({
    required String uid,
    required String courseId,
  }) =>
      _userDoc(uid).collection(userProgressSubcollection).doc(courseId);

  /// Full collection stream (no `orderBy` in Firestore) to avoid index issues and to
  /// include docs that might miss an `order` field. Filter/sort in memory.
  Stream<List<TrainingCourse>> watchCourses() {
    return _coursesCol().snapshots().map((snap) {
      final all = snap.docs.map(TrainingCourse.fromFirestore).toList();
      final active = all.where((c) => c.isActive).toList();
      active.sort((a, b) => a.order.compareTo(b.order));
      return active;
    });
  }

  Stream<Map<String, TrainingCourseProgress>> watchMyProgress() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value(const <String, TrainingCourseProgress>{});
    }
    final uid = user.uid;
    return _userDoc(uid)
        .collection(userProgressSubcollection)
        .snapshots()
        .map((snap) {
      final map = <String, TrainingCourseProgress>{};
      for (final d in snap.docs) {
        final p = TrainingCourseProgress.fromFirestore(d);
        map[p.courseId] = p;
      }
      return map;
    });
  }

  Stream<({String? activeCourseId, int unlockedUpToOrder})> watchMyTrainingGate() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value((
        activeCourseId: null,
        unlockedUpToOrder: 0,
      ));
    }
    final uid = user.uid;
    return _userDoc(uid).snapshots().map((doc) {
      final data = doc.data() ?? const <String, dynamic>{};
      return (
        activeCourseId: (data['activeTrainingCourseId'] as String?),
        unlockedUpToOrder: (data['trainingUnlockedUpToOrder'] as num?)?.toInt() ?? 0,
      );
    });
  }

  /// Aggregated training stats.
  ///
  /// **Source of truth**: `users/{uid}` fields so they show on the main user doc:
  /// - `trainingPointsEarned`
  /// - `trainingMinutesSpent`
  ///
  /// We still write the same fields to `users/{uid}/appTraining/summary` as well.
  Stream<({int pointsEarned, int minutesSpent})> watchTrainingStats() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value((
        pointsEarned: 0,
        minutesSpent: 0,
      ));
    }
    final uid = user.uid;
    return _userDoc(uid).snapshots().map((doc) {
      final d = doc.data() ?? const <String, dynamic>{};
      return (
        pointsEarned: (d['trainingPointsEarned'] as num?)?.toInt() ?? 0,
        minutesSpent: (d['trainingMinutesSpent'] as num?)?.toInt() ?? 0,
      );
    });
  }

  Future<void> startCourse({
    required String courseId,
    required int courseOrder,
  }) async {
    final uid = _uid;
    await _firestore.runTransaction((tx) async {
      final userRef = _userDoc(uid);
      final userSnap = await tx.get(userRef);
      final data = userSnap.data() ?? const <String, dynamic>{};
      final active = data['activeTrainingCourseId'] as String?;
      if (active != null && active.isNotEmpty && active != courseId) {
        return;
      }

      final unlocked =
          (data['trainingUnlockedUpToOrder'] as num?)?.toInt() ?? 0;
      if (courseOrder > unlocked) {
        return;
      }

      tx.set(
        userRef,
        {
          'activeTrainingCourseId': courseId,
          'trainingUnlockedUpToOrder': unlocked,
        },
        SetOptions(merge: true),
      );

      final now = DateTime.now();
      tx.set(
        _progressDoc(uid: uid, courseId: courseId),
        TrainingCourseProgress(
          courseId: courseId,
          status: TrainingCourseStatus.inProgress,
          progress01: 0,
          lessonDone: false,
          quizBestScore01: 0,
          challengeSubmitted: false,
          lastStep: 'video',
          updatedAt: now,
          assignedAt: now,
          quizAttempts: 0,
        ).toFirestore(),
        SetOptions(merge: true),
      );
    });
  }

  Future<void> updateProgress({
    required String courseId,
    TrainingCourseStatus? status,
    bool? lessonDone,
    double? quizBestScore01,
    bool? challengeSubmitted,
    String? lastStep,
    double? progress01,
    int? quizAttempts,
    int? lastSelectedAnswerIndex,
    DateTime? completedAt,
  }) async {
    final uid = _uid;
    final now = DateTime.now();
    await _progressDoc(uid: uid, courseId: courseId).set(
      {
        'courseId': courseId,
        if (status != null) 'status': status.name,
        if (lessonDone != null) 'lessonDone': lessonDone,
        if (quizBestScore01 != null) 'quizBestScore01': quizBestScore01,
        if (challengeSubmitted != null) 'challengeSubmitted': challengeSubmitted,
        if (lastStep != null) 'lastStep': lastStep,
        if (progress01 != null) 'progress01': progress01.clamp(0, 1),
        if (quizAttempts != null) 'quizAttempts': quizAttempts,
        if (lastSelectedAnswerIndex != null)
          'lastSelectedAnswerIndex': lastSelectedAnswerIndex,
        if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt),
        'updatedAt': Timestamp.fromDate(now),
      },
      SetOptions(merge: true),
    );
  }

  /// [ecoPoints] / [estimatedMinutes] are fallbacks; server reads the `course` doc in the
  /// same transaction for `ecoPoints` / `estimatedMinutes`.
  ///
  /// User aggregates increment when this completion **credits** stats: first time this
  /// course is finished, or legacy completed rows without [statsCredited]. Replays after
  /// [statsCredited] is true do not double-count.
  Future<void> completeCourse({
    required String courseId,
    required int courseOrder,
    int ecoPoints = 0,
    int estimatedMinutes = 0,
  }) async {
    final uid = _uid;
    final now = DateTime.now();
    await _firestore.runTransaction((tx) async {
      final userRef = _userDoc(uid);
      final progressRef = _progressDoc(uid: uid, courseId: courseId);
      final courseRef = _coursesCol().doc(courseId);

      final userSnap = await tx.get(userRef);
      final progressSnap = await tx.get(progressRef);
      final courseSnap = await tx.get(courseRef);

      final courseData = courseSnap.data() ?? const <String, dynamic>{};
      var points = (courseData['ecoPoints'] as num?)?.toInt() ?? 0;
      var minutes = (courseData['estimatedMinutes'] as num?)?.toInt() ?? 0;
      if (points <= 0) points = ecoPoints;
      if (minutes <= 0) minutes = estimatedMinutes;

      final progressData = progressSnap.data() ?? const <String, dynamic>{};
      final wasCompleted =
          (progressData['status'] as String?) ==
          TrainingCourseStatus.completed.name;
      final statsCredited = progressData['statsCredited'] == true;
      final shouldCreditStats = !wasCompleted || (wasCompleted && !statsCredited);

      final data = userSnap.data() ?? const <String, dynamic>{};
      final unlocked =
          (data['trainingUnlockedUpToOrder'] as num?)?.toInt() ?? 0;
      final nextUnlocked = (courseOrder + 1) > unlocked ? (courseOrder + 1) : unlocked;

      final userUpdate = <String, dynamic>{
        'activeTrainingCourseId': FieldValue.delete(),
        'trainingUnlockedUpToOrder': nextUnlocked,
      };
      if (shouldCreditStats) {
        if (points > 0) {
          userUpdate['trainingPointsEarned'] = FieldValue.increment(points);
        }
        if (minutes > 0) {
          userUpdate['trainingMinutesSpent'] = FieldValue.increment(minutes);
        }
      }
      tx.set(userRef, userUpdate, SetOptions(merge: true));

      if (shouldCreditStats) {
        final statsRef = _trainingStatsDoc(uid);
        final statsUpdate = <String, dynamic>{};
        if (points > 0) {
          statsUpdate['trainingPointsEarned'] = FieldValue.increment(points);
        }
        if (minutes > 0) {
          statsUpdate['trainingMinutesSpent'] = FieldValue.increment(minutes);
        }
        if (statsUpdate.isNotEmpty) {
          tx.set(statsRef, statsUpdate, SetOptions(merge: true));
        }
      }

      final progressWrite = <String, dynamic>{
        'courseId': courseId,
        'status': TrainingCourseStatus.completed.name,
        'progress01': 1.0,
        'completedAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
        if (shouldCreditStats) 'statsCredited': true,
      };
      tx.set(progressRef, progressWrite, SetOptions(merge: true));
    });
  }

  /// If the `course` collection is empty, pushes the asset JSON. Requires a signed-in
  /// user (rules). Fails silently when not signed in so the UI can still list courses
  /// if an admin added them (only watch error would apply).
  Future<void> seedDemoCoursesIfEmpty() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    if (!kPushTrainingJsonToFirestore) {
      final snap = await _coursesCol().limit(1).get();
      if (snap.docs.isNotEmpty) return;
    }
    try {
      await uploadAllCoursesFromAsset();
    } catch (_) {
      // e.g. permission denied, rules, or empty JSON — do not block training screen.
    }
  }
}
