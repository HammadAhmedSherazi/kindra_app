import 'package:flutter/material.dart';

import 'colors.dart';

extension Spacing on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension AppContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textStyle => theme.textTheme;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Roboto Flex - Regular (400)
  TextStyle robotoFlexRegular({double? fontSize, Color? color}) =>
      TextStyle(
        fontFamily: 'Roboto Flex',
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.primaryTextColor,
      );

  /// Roboto Flex - Medium (500)
  TextStyle robotoFlexMedium({double? fontSize, Color? color}) =>
      TextStyle(
        fontFamily: 'Roboto Flex',
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.primaryTextColor,
      );

  /// Roboto Flex - SemiBold (600)
  TextStyle robotoFlexSemiBold({double? fontSize, Color? color}) =>
      TextStyle(
        fontFamily: 'Roboto Flex',
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.primaryTextColor,
      );

  /// Roboto Flex - Bold (700)
  TextStyle robotoFlexBold({double? fontSize, Color? color}) =>
      TextStyle(
        fontFamily: 'Roboto Flex',
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.primaryTextColor,
      );
}

extension StringExtension on String {
  String toTitleCase() {
    return toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}
