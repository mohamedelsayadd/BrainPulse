import 'package:flutter/material.dart';

class AppHelperFunctions {
  //Singelton Instance
  static final AppHelperFunctions _instance = AppHelperFunctions._internal();

  factory AppHelperFunctions() => _instance;

  AppHelperFunctions._internal();

  PageRouteBuilder<dynamic> slideFromBottomTransition({required Widget page}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        const Offset begin = Offset(0, 1);
        const Offset end = Offset.zero;
        const Cubic curve = Curves.easeOutQuint;
        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  PageRouteBuilder<dynamic> slideFromRightTransition({required Widget page}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        const Offset begin = Offset(1, 0);
        const Offset end = Offset.zero;
        const Cubic curve = Curves.easeOutQuint;
        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  PageRouteBuilder<dynamic> fadeTransition({required Widget page}) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
