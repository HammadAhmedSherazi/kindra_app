import '../data/demo_cleanup_events.dart';
import '../utils/assets.dart';
import 'custom_button_widget.dart';
import 'package:flutter/material.dart';

/// Generic card for a cleanup event. Use in Dashboard (upcoming) and Cleanups tab (Upcoming / Past).
class CleanupEventCard extends StatelessWidget {
  const CleanupEventCard({
    super.key,
    required this.event,
    required this.isUpcoming,
    this.onTap,
    this.onActionPressed,
  });

  final CleanupEventItem event;
  final bool isUpcoming;
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: SizedBox(
        height: 114,
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                height: double.infinity,
                width: 114,
                color: Colors.grey.shade200,
                child: event.imagePath != null
                    ? Image.asset(
                        event.imagePath!,
                        height: double.infinity,
                        width: 114,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildIconFallback(),
                      )
                    : _buildIconFallback(),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    event.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.66),
                      fontSize: 13,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w300,
                      height: 1.37,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 4,
                          children: [
                            Image.asset(
                              Assets.communityMemberIcon,
                              width: 18,
                              height: 18,
                              color: Colors.black.withValues(alpha: 0.40),
                            ),
                            Text(
                              '${event.members} Members',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.40),
                                fontSize: 13,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w300,
                                height: 1.14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          spacing: 4,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.black.withValues(alpha: 0.40),
                              size: 18,
                            ),
                            Text(
                              event.date,
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.40),
                                fontSize: 13,
                                fontFamily: 'Roboto Flex',
                                fontWeight: FontWeight.w300,
                                height: 1.14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomButtonWidget(
                        height: 32,
                        expandWidth: false,
                        backgroundColor: const Color(0xff525252),
                        textSize: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        label: isUpcoming ? 'Join Event' : 'View',
                        onPressed: onActionPressed ?? () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconFallback() {
    return Center(
      child: Image.asset(
        Assets.cleanupIcon,
        width: 48,
        height: 48,
        color: Colors.grey.shade600,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(Icons.clean_hands, size: 48, color: Colors.grey.shade400),
      ),
    );
  }
}
