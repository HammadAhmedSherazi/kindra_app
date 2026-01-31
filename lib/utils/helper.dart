import 'package:flutter/material.dart';

import 'colors.dart';

class Helper {
  Helper._();

  static void showMessage(
    BuildContext context, {
    required String message,
    Color backgroundColor = AppColors.primaryColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showFullScreenLoader(BuildContext context,
      {bool dismissible = false}) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black54,
      useRootNavigator: true,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  static void hideFullScreenLoader(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
