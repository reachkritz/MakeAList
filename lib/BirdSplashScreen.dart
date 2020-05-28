import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';

class BirdSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BirdSplashScreenState();
  }
}

class BirdSplashScreenState extends State<BirdSplashScreen> with SingleTickerProviderStateMixin  {
  static const _icons = <String>[
    'assets/icons/IconBird.0.png',
    'assets/icons/IconBird.1.png',
    'assets/icons/IconBird.2.png'
  ];
  int selected = 0;
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = IntTween(begin: 0, end: 30).animate(_controller)
    ..addListener(() {
      setState(() {
        selected = _animation.value%3;
      });
     });
    _controller.forward();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'),
          ));
    });
  }

  Stack _fetchIcon(){
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80,
        ),
        Positioned(
          child: Image.asset(_icons[selected],
            height: 200,
            width: 250,
            fit: BoxFit.fitWidth,),
          left: -40,
          top: -20,
        )
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