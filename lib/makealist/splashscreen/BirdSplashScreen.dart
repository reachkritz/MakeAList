import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../home/MyHomePage.dart';
import '../route/SlidingRouteBuilder.dart';

class BirdSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BirdSplashScreenState();
  }
}

class BirdSplashScreenState extends State<BirdSplashScreen>
    with SingleTickerProviderStateMixin {
  static const _icons = <String>[
    'assets/icons/IconBird.0.png',
    'assets/icons/IconBird.1.png',
    'assets/icons/IconBird.2.png'
  ];
  int selected = 0;
  AnimationController _controller;
  Animation _animation;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _animation = IntTween(begin: 0, end: 50)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate))
          ..addListener(() {
            setState(() {
              selected = _animation.value % 3;
            });
          });
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, -1),
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.easeIn)));
    _controller.forward();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(context, SlidingRouteBuilder(secondScreen: MyHomePage()));
    });
  }

  Stack _fetchIcon() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80,
        ),
        SlideTransition(
            position: _offsetAnimation,
            child: Positioned(
              child: Image.asset(
                _icons[selected],
                height: 200,
                width: 250,
                fit: BoxFit.fitWidth,
              ),
              left: -40,
              top: -20,
            ))
      ],
      overflow: Overflow.visible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCE4EC),
      body: Center(
        child: _fetchIcon(),
      ),
    );
  }
}
