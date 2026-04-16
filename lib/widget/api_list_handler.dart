import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef ApiItemWidgetBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

class ApiListHandler<T> extends StatefulWidget {
  const ApiListHandler({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.isLoadingInitial,
    required this.isLoadingMore,
    required this.hasMore,
    required this.error,
    required this.onRetry,
    this.onRefresh,
    this.onLoadMore,
    this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.empty,
    this.skeletonItem,
    this.skeletonCount = 6,
    this.loadMoreThresholdFraction = 0.8,
    this.onScroll,
  });

  final List<T> items;
  final ApiItemWidgetBuilder<T> itemBuilder;

  /// Initial page loading.
  final bool isLoadingInitial;

  /// Pagination loading.
  final bool isLoadingMore;

  /// Whether more pages exist.
  final bool hasMore;

  /// Any error from the fetch.
  final Object? error;

  final VoidCallback onRetry;

  /// Optional pull-to-refresh.
  final Future<void> Function()? onRefresh;

  /// Called when user scrolls near the end.
  final VoidCallback? onLoadMore;

  /// Optional external controller (won't be disposed).
  final ScrollController? controller;

  final EdgeInsets padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;

  /// Widget to show when loaded but empty.
  final Widget? empty;

  /// Placeholder widget used for skeleton rows.
  final Widget? skeletonItem;
  final int skeletonCount;

  /// How close to the end to trigger [onLoadMore].
  final double loadMoreThresholdFraction;

  /// Optional raw scroll callback.
  final void Function(ScrollMetrics metrics)? onScroll;

  @override
  State<ApiListHandler<T>> createState() => _ApiListHandlerState<T>();
}

class _ApiListHandlerState<T> extends State<ApiListHandler<T>> {
  late final ScrollController _internalController;
  ScrollController get _controller => widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = ScrollController();
    _controller.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(covariant ApiListHandler<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      (oldWidget.controller ?? _internalController).removeListener(_handleScroll);
      _controller.addListener(_handleScroll);
    }
  }

  void _handleScroll() {
    if (!_controller.hasClients) return;
    final pos = _controller.position;
    widget.onScroll?.call(pos);

    final onLoadMore = widget.onLoadMore;
    if (onLoadMore == null) return;
    if (widget.isLoadingInitial || widget.isLoadingMore) return;
    if (!widget.hasMore) return;
    if (pos.maxScrollExtent <= 0) return;

    final threshold = pos.maxScrollExtent * widget.loadMoreThresholdFraction;
    if (pos.pixels >= threshold) {
      onLoadMore();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;

    if (widget.isLoadingInitial && items.isEmpty) {
      return _SkeletonList(
        padding: widget.padding,
        item: widget.skeletonItem ?? const _DefaultSkeletonItem(),
        count: widget.skeletonCount,
        separator: widget.separator,
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
      );
    }

    if (widget.error != null && items.isEmpty) {
      return _ErrorState(
        onRetry: widget.onRetry,
      );
    }

    if (!widget.isLoadingInitial && items.isEmpty) {
      return widget.empty ??
          Center(
            child: Text(
              'No data found',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.55),
                fontSize: 14,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w400,
              ),
            ),
          );
    }

    Widget list = ListView.separated(
      controller: _controller,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      padding: widget.padding,
      itemCount: items.length + (widget.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              ),
            ),
          );
        }
        return widget.itemBuilder(context, index, items[index]);
      },
      separatorBuilder: (context, index) =>
          widget.separator ?? const SizedBox(height: 12),
    );

    final onRefresh = widget.onRefresh;
    if (onRefresh != null) {
      list = RefreshIndicator.adaptive(onRefresh: onRefresh, child: list);
    }

    return list;
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.75),
                fontSize: 14,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonList extends StatelessWidget {
  const _SkeletonList({
    required this.padding,
    required this.item,
    required this.count,
    required this.separator,
    required this.shrinkWrap,
    required this.physics,
  });

  final EdgeInsets padding;
  final Widget item;
  final int count;
  final Widget? separator;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding,
        itemCount: count,
        itemBuilder: (context, index) => item,
        separatorBuilder: (context, index) =>
            separator ?? const SizedBox(height: 12),
      ),
    );
  }
}

class _DefaultSkeletonItem extends StatelessWidget {
  const _DefaultSkeletonItem();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Container(
              width: 114,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 6),
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Container(
                  height: 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Container(
                  height: 12,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

