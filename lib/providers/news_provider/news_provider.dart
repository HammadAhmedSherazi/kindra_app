import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/news_model.dart';
import '../../services/news_service.dart';

class HouseholdNewsState {
  const HouseholdNewsState({
    required this.items,
    required this.hasMore,
    required this.isLoadingInitial,
    required this.isLoadingMore,
    required this.lastDoc,
    required this.error,
  });

  final List<NewsModel> items;
  final bool hasMore;
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  final Object? error;

  factory HouseholdNewsState.initial() => const HouseholdNewsState(
        items: <NewsModel>[],
        hasMore: true,
        isLoadingInitial: true,
        isLoadingMore: false,
        lastDoc: null,
        error: null,
      );

  HouseholdNewsState copyWith({
    List<NewsModel>? items,
    bool? hasMore,
    bool? isLoadingInitial,
    bool? isLoadingMore,
    DocumentSnapshot<Map<String, dynamic>>? lastDoc,
    Object? error,
  }) {
    return HouseholdNewsState(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      lastDoc: lastDoc ?? this.lastDoc,
      error: error,
    );
  }
}

final newsServiceProvider = Provider<NewsService>((ref) => NewsService());

final householdNewsProvider =
    NotifierProvider<HouseholdNewsNotifier, HouseholdNewsState>(
  HouseholdNewsNotifier.new,
);

class HouseholdNewsNotifier extends Notifier<HouseholdNewsState> {
  static const int _pageSize = 10;

  @override
  HouseholdNewsState build() {
    state = HouseholdNewsState.initial();
    Future.microtask(fetchFirstPage);
    return state;
  }

  Future<void> fetchFirstPage() async {
    state = state.copyWith(
      isLoadingInitial: true,
      isLoadingMore: false,
      hasMore: true,
      error: null,
      items: const <NewsModel>[],
      lastDoc: null,
    );

    try {
      final page = await ref.read(newsServiceProvider).fetchNewsPage(
            pageSize: _pageSize,
            startAfter: null,
          );

      state = state.copyWith(
        items: page.items,
        lastDoc: page.lastDoc,
        hasMore: page.hasMore,
        isLoadingInitial: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoadingInitial: false, error: e);
    }
  }

  Future<void> fetchNextPage() async {
    if (!state.hasMore) return;
    if (state.isLoadingInitial || state.isLoadingMore) return;
    if (state.lastDoc == null && state.items.isNotEmpty) return;

    state = state.copyWith(isLoadingMore: true, error: null);

    try {
      final page = await ref.read(newsServiceProvider).fetchNewsPage(
            pageSize: _pageSize,
            startAfter: state.lastDoc,
          );

      final merged = <NewsModel>[
        ...state.items,
        ...page.items.where((n) => !_containsId(state.items, n.id)),
      ];

      state = state.copyWith(
        items: merged,
        lastDoc: page.lastDoc ?? state.lastDoc,
        hasMore: page.hasMore,
        isLoadingMore: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e);
    }
  }

  Future<void> refresh() => fetchFirstPage();

  bool _containsId(List<NewsModel> items, String? id) {
    if (id == null) return false;
    return items.any((e) => e.id == id);
  }
}

