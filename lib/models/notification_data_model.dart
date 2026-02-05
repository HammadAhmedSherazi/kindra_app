/// Model for notification items from API or local list.
/// [timestamp] is used to group into "Today" and "Last week".
class NotificationDataModel {
  const NotificationDataModel({
    required this.id,
    required this.title,
    required this.timestamp,
    this.isRead = false,
    this.iconType = NotificationIconType.reward,
  });

  final String id;
  final String title;
  final DateTime timestamp;
  final bool isRead;
  final NotificationIconType iconType;

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? json['message'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isRead: json['is_read'] as bool? ?? false,
      iconType: _iconTypeFromJson(json['icon_type']),
    );
  }

  static NotificationIconType _iconTypeFromJson(dynamic value) {
    if (value == null) return NotificationIconType.reward;
    final s = value.toString().toLowerCase();
    if (s == 'news') return NotificationIconType.news;
    return NotificationIconType.reward;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'timestamp': timestamp.toIso8601String(),
        'is_read': isRead,
        'icon_type': iconType.name,
      };

  NotificationDataModel copyWith({
    String? id,
    String? title,
    DateTime? timestamp,
    bool? isRead,
    NotificationIconType? iconType,
  }) {
    return NotificationDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      iconType: iconType ?? this.iconType,
    );
  }
}

enum NotificationIconType {
  reward, // bookmark with plus - e.g. Point successfully redeemed, Latest News
  news,  // bookmark with slash - e.g. Last News
}
