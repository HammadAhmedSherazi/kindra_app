import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/news_model.dart';

class NewsPage {
  const NewsPage({
    required this.items,
    required this.lastDoc,
    required this.hasMore,
  });

  final List<NewsModel> items;
  final DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  final bool hasMore;
}

class NewsService {
  NewsService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _newsCol =>
      _firestore.collection('news');

  Future<NewsPage> fetchNewsPage({
    required int pageSize,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  }) async {
    Future<QuerySnapshot<Map<String, dynamic>>> runQuerySimpleFirstPage() {
      // No orderBy => least chance of index issues.
      // Only safe for the first page (no cursor pagination).
      return _newsCol
          .where('isActive', isEqualTo: true)
          .limit(pageSize)
          .get();
    }

    Future<QuerySnapshot<Map<String, dynamic>>> runQueryCreatedAt() {
      Query<Map<String, dynamic>> query = _newsCol
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(pageSize);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      return query.get();
    }

    Future<QuerySnapshot<Map<String, dynamic>>> runQueryById() {
      Query<Map<String, dynamic>> query = _newsCol
          .where('isActive', isEqualTo: true)
          .orderBy(FieldPath.documentId)
          .limit(pageSize);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      return query.get();
    }

    QuerySnapshot<Map<String, dynamic>> snap;
    try {
      snap = await runQueryCreatedAt();
      if (snap.docs.isEmpty && startAfter == null) {
        // If createdAt is missing/wrong type on existing docs, the query can
        // silently return empty. Fallback to documentId ordering so at least
        // active docs show up until createdAt is backfilled.
        snap = await runQueryById();
      }
    } catch (_) {
      // If index/permission/field issues happen, try the simplest query for
      // first page so UI can still show data.
      if (startAfter == null) {
        snap = await runQuerySimpleFirstPage();
      } else {
        snap = await runQueryById();
      }
    }
    final docs = snap.docs;
    final items = docs.map(NewsModel.fromFirestore).toList(growable: false);
    final last = docs.isNotEmpty ? docs.last : null;

    return NewsPage(
      items: items,
      lastDoc: last,
      hasMore: docs.length == pageSize,
    );
  }
}

