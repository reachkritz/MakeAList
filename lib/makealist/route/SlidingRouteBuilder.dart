import 'package:flutter/cupertino.dart';

class SlidingRouteBuilder extends PageRouteBuilder {
  final Widget secondScreen;

  SlidingRouteBuilder({this.secondScreen})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) =>
                secondScreen,
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, widget) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: widget,
              );
            });
}
