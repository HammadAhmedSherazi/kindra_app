import 'package:flutter/material.dart';

import '../utils/assets.dart';

/// A card with an optional centered overlay (e.g. icon badge) that can overflow
/// above the card. Use [child] for card content and [overlay] for the top widget.
class CardWithOverlayWidget extends StatelessWidget {
  const CardWithOverlayWidget({
    super.key,
    required this.child,
    this.overlay,
    this.cardMargin,
    this.cardPadding,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.overlayTop,
  });

  /// Content inside the card.
  final Widget child;

  /// Widget shown centered above the card (e.g. circle with icon). If null,
  /// shows default green circle with check icon.
  final Widget? overlay;

  /// Margin around the card. Default: `EdgeInsets.only(top: 40)`.
  final EdgeInsets? cardMargin;

  /// Padding inside the card. Default: `EdgeInsets.only(top: 56, left: 20, right: 20, bottom: 24)`.
  final EdgeInsets? cardPadding;

  /// Card border radius. Default: `23`.
  final double? borderRadius;

  /// Card border color. Default: `Color(0xFFD9D9D9)`.
  final Color? borderColor;

  /// Card border width. Default: `1`.
  final double? borderWidth;

  /// Top offset for overlay (negative to overlap card). Default: `-40`.
  final double? overlayTop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: cardMargin ?? const EdgeInsets.only(top: 40),
          padding: cardPadding ??
              const EdgeInsets.only(
                top: 56,
                left: 20,
                right: 20,
                bottom: 24,
              ),
          decoration: BoxDecoration(
            border: Border.all(
              width: borderWidth ?? 1,
              color: borderColor ?? const Color(0xFFD9D9D9),
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 23),
          ),
          child: child,
        ),
        Positioned(
          top: overlayTop ?? -40,
          left: 0,
          right: 0,
          child: Center(
            child: overlay ?? _defaultOverlay(),
          ),
        ),
      ],
    );
  }

  Widget _defaultOverlay() {
    return Container(
      width: 121,
      height: 121,
      decoration: const BoxDecoration(
        color: Color(0xff4C9A31),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          Assets.checkedIcon,
          width: 56,
          height: 56,
        ),
      ),
    );
  }
}
