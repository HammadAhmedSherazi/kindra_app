/// Type of history entry for tab filtering.
enum HistoryEntryType {
  points,
  garbage,
}

/// Single history list item for History screen.
class HistoryItem {
  const HistoryItem({
    required this.type,
    required this.title,
    required this.time,
    required this.amount,
    required this.dateGroup,
  });

  final HistoryEntryType type;
  final String title;
  final String time;
  /// Signed amount: positive for credit (e.g. +2000), negative for debit (e.g. -500).
  final int amount;
  /// Section header label, e.g. "Today", "Monday, December 15, 2024".
  final String dateGroup;

  String get amountDisplay => amount >= 0 ? '+$amount' : '$amount';
  bool get isPositive => amount >= 0;
}

/// Data for the History Detail screen (e.g. garbage redemption success).
class HistoryDetailData {
  const HistoryDetailData({
    required this.title,
    required this.pointsAwarded,
    required this.status,
    required this.redemptionId,
    required this.typeOfWaste,
    required this.garbageWeight,
    required this.date,
    required this.totalPoints,
  });

  final String title;
  final int pointsAwarded;
  final String status;
  final String redemptionId;
  final String typeOfWaste;
  final String garbageWeight;
  final String date;
  final int totalPoints;
}

HistoryDetailData historyDetailFromItem(HistoryItem item) {
  final isGarbage = item.type == HistoryEntryType.garbage;
  return HistoryDetailData(
    title: isGarbage ? 'Garbage Redemption Successful' : 'Point Redemption successful',
    pointsAwarded: item.amount.abs(),
    status: 'Success',
    redemptionId: '0 123 456 ****',
    typeOfWaste: isGarbage ? 'Non-organic Waste' : '—',
    garbageWeight: isGarbage ? '500 gram' : '—',
    date: item.dateGroup == 'Today' ? 'Wednesday, July 3, 2025' : item.dateGroup,
    totalPoints: item.amount.abs(),
  );
}

final List<HistoryItem> demoHistoryList = [
  // Today
  HistoryItem(
    type: HistoryEntryType.points,
    title: 'Point Redemption successful',
    time: '09:20 AM',
    amount: -500,
    dateGroup: 'Today',
  ),
  HistoryItem(
    type: HistoryEntryType.garbage,
    title: 'Garbage Handover',
    time: '09:20 AM',
    amount: 2000,
    dateGroup: 'Today',
  ),
  HistoryItem(
    type: HistoryEntryType.points,
    title: 'Point Redemption successful',
    time: '09:20 AM',
    amount: -7000,
    dateGroup: 'Today',
  ),
  // Monday, December 15, 2024
  HistoryItem(
    type: HistoryEntryType.points,
    title: 'Point Redemption successful',
    time: '09:20 AM',
    amount: -500,
    dateGroup: 'Monday, December 15, 2024',
  ),
  HistoryItem(
    type: HistoryEntryType.garbage,
    title: 'Garbage Handover',
    time: '09:20 AM',
    amount: 2000,
    dateGroup: 'Monday, December 15, 2024',
  ),
  HistoryItem(
    type: HistoryEntryType.points,
    title: 'Point Redemption successful',
    time: '09:20 AM',
    amount: -7000,
    dateGroup: 'Monday, December 15, 2024',
  ),
  HistoryItem(
    type: HistoryEntryType.points,
    title: 'Point Redemption successful',
    time: '09:20 AM',
    amount: -500,
    dateGroup: 'Monday, December 15, 2024',
  ),
  HistoryItem(
    type: HistoryEntryType.garbage,
    title: 'Garbage Handover',
    time: '00:00 AM',
    amount: 2000,
    dateGroup: 'Monday, December 15, 2024',
  ),
];
