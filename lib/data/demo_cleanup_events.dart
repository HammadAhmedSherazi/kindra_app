/// Model for a cleanup event (upcoming or past).
class CleanupEventItem {
  const CleanupEventItem({
    required this.title,
    required this.location,
    required this.members,
    required this.date,
    this.imagePath,
    this.imageUrl,
  });

  final String title;
  final String location;
  final String members;
  final String date;
  /// Optional asset image path; if null, card may use [imageUrl] or cleanup icon.
  final String? imagePath;
  /// Optional network image URL; displayed in card when set.
  final String? imageUrl;
}

/// Demo upcoming cleanup events (e.g. from "network").
const List<CleanupEventItem> demoUpcomingCleanupEvents = [
  CleanupEventItem(
    title: 'Beach Cleanup in Arcata Bay',
    location: 'Arcata Bay, CA',
    members: '157',
    date: '20 Jun 2025',
    imageUrl: 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400',
  ),
  CleanupEventItem(
    title: 'Coastal Trail Cleanup',
    location: 'Humboldt County, CA',
    members: '89',
    date: '28 Jun 2025',
    imageUrl: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
  ),
  CleanupEventItem(
    title: 'Marina Beach Cleanup',
    location: 'Eureka, CA',
    members: '203',
    date: '5 Jul 2025',
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
  ),
];

/// Demo past cleanup events (e.g. from "network").
const List<CleanupEventItem> demoPastCleanupEvents = [
  CleanupEventItem(
    title: 'Beach Cleanup in Arcata Bay',
    location: 'Arcata Bay, CA',
    members: '142',
    date: '15 May 2025',
    imageUrl: 'https://images.unsplash.com/photo-1506953823976-4e27c477e694?w=400',
  ),
  CleanupEventItem(
    title: 'River Mouth Cleanup',
    location: 'Trinidad, CA',
    members: '98',
    date: '3 May 2025',
    imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
  ),
  CleanupEventItem(
    title: 'Dunes Cleanup Day',
    location: 'Samoa, CA',
    members: '76',
    date: '19 Apr 2025',
    imageUrl: 'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=400',
  ),
];
