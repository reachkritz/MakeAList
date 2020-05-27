import 'package:flutter/material.dart';
import 'package:makealist/BirdSplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Make a List!',
        theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.grey[600],
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: MaterialApp(home: BirdSplashScreen()),
    );
  }
}
