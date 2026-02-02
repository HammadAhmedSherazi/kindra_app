import 'package:flutter/material.dart';

import 'custom_back_arrow_widget.dart';

/// Back button with oval background and custom arrow. Fixed 32x40.
/// Same style on both iOS and Android.
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  static const double _width = 32;
  static const double _height = 40;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: _width,
          height: _height,
          decoration: const ShapeDecoration(
            color: Color(0xFFEFEFEF),
            shape: OvalBorder(),
          ),
          alignment: Alignment.center,
          child: const CustomBackArrowWidget(
            width: 10,
            height: 16,
            color: Colors.black,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
