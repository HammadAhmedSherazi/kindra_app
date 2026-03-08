/// Model for a cleanup event (upcoming or past).
class CleanupEventItem {
  const CleanupEventItem({
    required this.title,
    required this.location,
    required this.members,
    required this.date,
    this.imagePath,
  });

  final String title;
  final String location;
  final String members;
  final String date;
  /// Optional image path; if null, card uses cleanup icon.
  final String? imagePath;
}

/// Demo upcoming cleanup events (e.g. from "network").
const List<CleanupEventItem> demoUpcomingCleanupEvents = [
  CleanupEventItem(
    title: 'Beach Cleanup in Arcata Bay',
    location: 'Arcata Bay, CA',
    members: '157',
    date: '20 Jun 2025',
  ),
  CleanupEventItem(
    title: 'Coastal Trail Cleanup',
    location: 'Humboldt County, CA',
    members: '89',
    date: '28 Jun 2025',
  ),
  CleanupEventItem(
    title: 'Marina Beach Cleanup',
    location: 'Eureka, CA',
    members: '203',
    date: '5 Jul 2025',
  ),
];

/// Demo past cleanup events (e.g. from "network").
const List<CleanupEventItem> demoPastCleanupEvents = [
  CleanupEventItem(
    title: 'Beach Cleanup in Arcata Bay',
    location: 'Arcata Bay, CA',
    members: '142',
    date: '15 May 2025',
  ),
  CleanupEventItem(
    title: 'River Mouth Cleanup',
    location: 'Trinidad, CA',
    members: '98',
    date: '3 May 2025',
  ),
  CleanupEventItem(
    title: 'Dunes Cleanup Day',
    location: 'Samoa, CA',
    members: '76',
    date: '19 Apr 2025',
  ),
];
