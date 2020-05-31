import 'package:flutter/material.dart';
import 'makealist/splashscreen/BirdSplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Make a List!',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BirdSplashScreen(),
    );
  }
}
