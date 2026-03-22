import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../../utils/extension.dart';

/// Layout constants for driver profile and related sub-screens.
const double kDriverProfileHeaderHeight = 232;
const double kDriverProfileAvatarSize = 92;

/// Avatar overlapping the green header; [onBadgeTap] for edit/upload affordance.
class DriverProfileOverlappingAvatar extends StatelessWidget {
  const DriverProfileOverlappingAvatar({
    super.key,
    this.onBadgeTap,
    this.displayName,
  });

  final VoidCallback? onBadgeTap;
  /// Shown centered under the avatar (e.g. profile tab only).
  final String? displayName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: kDriverProfileHeaderHeight - kDriverProfileAvatarSize / 2,
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: kDriverProfileAvatarSize,
              height: kDriverProfileAvatarSize,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        Assets.userAvatar,
                        width: kDriverProfileAvatarSize,
                        height: kDriverProfileAvatarSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: GestureDetector(
                      onTap: onBadgeTap,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.file_upload_outlined,
                          size: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (displayName != null) ...[
            10.ph,
            Text(
              displayName!,
              textAlign: TextAlign.center,
              style: context.robotoFlexBold(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Star row for ratings (e.g. 4.6).
class DriverRatingStarsRow extends StatelessWidget {
  const DriverRatingStarsRow({
    super.key,
    required this.rating,
    this.starSize = 18,
  });

  final double rating;
  final double starSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        IconData icon;
        if (rating >= starIndex) {
          icon = Icons.star_rounded;
        } else if (rating > starIndex - 1) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_outline_rounded;
        }
        return Icon(
          icon,
          size: starSize,
          color: const Color(0xFFE6B422),
        );
      }),
    );
  }
}
