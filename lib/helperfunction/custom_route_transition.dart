import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // TODO: implement buildTransitions

    if (route.settings.isInitialRoute) {
      return child;
    }
    var begin = Offset(-1.0, 0.0);
    var end = Offset.zero;
    var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeIn));
    var offSetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offSetAnimation,
      child: child,
    );
  }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = Offset(0.0, -0.8);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end)
        .chain(CurveTween(curve: Curves.easeInCirc));
    var offSetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offSetAnimation,
      child: child,
    );
  }
}
