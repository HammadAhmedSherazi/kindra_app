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
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.fontWeight,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final bool loading;
  final bool enabled;
  final double height;
  final bool expandWidth;
  final Widget? icon;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (enabled && !loading) ? onPressed : null;
    final effectiveTextColor = variant == CustomButtonVariant.outlined
        ? (textColor ?? backgroundColor ?? AppColors.primaryColor)
        : (textColor ?? Colors.white);

    Widget child = loading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == CustomButtonVariant.primary
                  ? Colors.white
                  : backgroundColor ?? AppColors.primaryColor,
            ),
          )
        : icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  8.pw,
                  Text(
                    label,
                    style: TextStyle(
                      color: effectiveTextColor,
                      fontSize: textSize ?? 23,
                      fontFamily: 'Roboto Flex',
                      fontWeight: fontWeight ?? FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Text(
                label,
                style: TextStyle(
                  color: effectiveTextColor,
                  fontSize: textSize ?? 23,
                  fontFamily: 'Roboto Flex',
                  fontWeight: fontWeight ?? FontWeight.w600,
                ),
              );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(variant == CustomButtonVariant.outlined ? 30 : 26),
    );

    switch (variant) {
      case CustomButtonVariant.primary:
        return SizedBox(
          width: expandWidth ? double.infinity : null,
          height: height,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              padding: padding,
              backgroundColor: backgroundColor ?? AppColors.primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.disableButtonColor,
              shape: RoundedRectangleBorder(
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
              padding: padding,
              backgroundColor: backgroundColor ?? AppColors.secondaryColor,
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
              padding: padding,
              backgroundColor: backgroundColor,

              foregroundColor: backgroundColor ?? AppColors.primaryColor,
              side: BorderSide(
                color: enabled ? borderColor ?? backgroundColor ?? AppColors.primaryColor : AppColors.borderColor,
              ),
              shape: shape,
            ),
            child: child,
          ),
        );
    }
  }
}
