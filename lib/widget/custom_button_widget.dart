import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/extension.dart';

enum CustomButtonVariant { primary, secondary, outlined }

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.loading = false,
    this.enabled = true,
    this.height = 52,
    this.expandWidth = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final bool loading;
  final bool enabled;
  final double height;
  final bool expandWidth;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (enabled && !loading) ? onPressed : null;

    Widget child = loading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == CustomButtonVariant.primary
                  ? Colors.white
                  : AppColors.primaryColor,
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  8.pw,
                  Text(label, style: TextStyle(
color: Colors.white,
fontSize: 23,
fontFamily: 'Roboto Flex',
fontWeight: FontWeight.w600,
),),
                ],
              )
            : Text(label, style: TextStyle(
color: Colors.white,
fontSize: 23,
fontFamily: 'Roboto Flex',
fontWeight: FontWeight.w600,
),);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

    switch (variant) {
      case CustomButtonVariant.primary:
        return SizedBox(
          width: expandWidth ? double.infinity : null,
          height: height,
          child: ElevatedButton(
            
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.disableButtonColor,
              shape:  RoundedRectangleBorder(
borderRadius: BorderRadius.circular(26),
),
            ),
            child: child,
          ),
        );
      case CustomButtonVariant.secondary:
        return SizedBox(
          width: expandWidth ? double.infinity : null,
          height: height,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.disableButtonColor,
              shape: shape,
            ),
            child: child,
          ),
        );
      case CustomButtonVariant.outlined:
        return SizedBox(
          width: expandWidth ? double.infinity : null,
          height: height,
          child: OutlinedButton(
            onPressed: effectiveOnPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: BorderSide(
                color: enabled ? AppColors.primaryColor : AppColors.borderColor,
              ),
              shape: shape,
            ),
            child: child,
          ),
        );
    }
  }
}
