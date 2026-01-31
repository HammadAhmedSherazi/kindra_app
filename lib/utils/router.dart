import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static void back() {
    Navigator.of(navKey.currentContext!).pop();
    FocusScope.of(navKey.currentContext!).unfocus();
  }

  static Future<void> push(Widget page) async {
    await Navigator.push(
      navKey.currentContext!,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<void> pushReplacement(Widget page) async {
    await Navigator.pushReplacement(
      navKey.currentContext!,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<void> pushAndRemoveUntil(Widget page) async {
    await Navigator.pushAndRemoveUntil(
      navKey.currentContext!,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static Future<void> pushWithAnimation(Widget page) async {
    await Navigator.push(
      navKey.currentContext!,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, _, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
