import '../models/notification_data_model.dart';

/// Demo list of notifications. Replace with API response when ready.
/// Group by "Today" and "Last week" using [NotificationHelper.groupByTodayAndLastWeek].
final List<NotificationDataModel> demoNotificationList = [
  // Today
  NotificationDataModel(
    id: '1',
    title: 'Point successfully redeemed',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)), // 09:20 AM style
    isRead: false,
    iconType: NotificationIconType.reward,
  ),
  NotificationDataModel(
    id: '2',
    title: 'Last News',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    isRead: true,
    iconType: NotificationIconType.news,
  ),
  // Last week
  NotificationDataModel(
    id: '3',
    title: 'Point successfully redeemed',
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    isRead: false,
    iconType: NotificationIconType.reward,
  ),
  NotificationDataModel(
    id: '4',
    title: 'Latest News',
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    isRead: false,
    iconType: NotificationIconType.reward,
  ),
  NotificationDataModel(
    id: '5',
    title: 'Last News',
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
    isRead: true,
    iconType: NotificationIconType.news,
  ),
  NotificationDataModel(
    id: '6',
    title: 'Last News',
    timestamp: DateTime.now().subtract(const Duration(days: 4)),
    isRead: true,
    iconType: NotificationIconType.news,
  ),
  NotificationDataModel(
    id: '7',
    title: 'Last News',
    timestamp: DateTime.now().subtract(const Duration(days: 5)),
    isRead: true,
    iconType: NotificationIconType.news,
  ),
  NotificationDataModel(
    id: '8',
    title: 'Last News',
    timestamp: DateTime.now().subtract(const Duration(days: 6)),
    isRead: true,
    iconType: NotificationIconType.news,
  ),
];

/// Groups a list of notifications by "Today" and "Last week" based on [timestamp].
/// Use this for API list: pass the list from API and get grouped sections.
class NotificationHelper {
  NotificationHelper._();

  static const String sectionToday = 'Today';
  static const String sectionLastWeek = 'Last week';

  static bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool _isLastWeek(DateTime date) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final sevenDaysAgo = todayStart.subtract(const Duration(days: 7));
    return dateOnly.isBefore(todayStart) && !dateOnly.isBefore(sevenDaysAgo);
  }

  /// Returns notifications grouped by "Today" and "Last week".
  /// Sorts each section by [timestamp] descending (newest first).
  static Map<String, List<NotificationDataModel>> groupByTodayAndLastWeek(
    List<NotificationDataModel> list,
  ) {
    final today = <NotificationDataModel>[];
    final lastWeek = <NotificationDataModel>[];

    for (final n in list) {
      if (_isToday(n.timestamp)) {
        today.add(n);
      } else if (_isLastWeek(n.timestamp)) {
        lastWeek.add(n);
      }
    }

    today.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    lastWeek.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return {
      sectionToday: today,
      sectionLastWeek: lastWeek,
    };
  }

  /// Formats [dateTime] as "09:20 AM" / "06:12 AM".
  static String formatTime(DateTime dateTime) {
    final h = dateTime.hour;
    final hour = h == 0 ? 12 : h > 12 ? h - 12 : h;
    final hourStr = hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hourStr:$minute $period';
  }
}
