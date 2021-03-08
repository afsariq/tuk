import 'package:AutoSale/Home/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 300,
        splash: Column(
          children: [
            Text(
              "TUK TOOK",
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic),
            ),
            Image.asset(
              "Assets/Images/spl.png",
              width: 150,
              height: 150,
            ),
          ],
        ),
        splashTransition: SplashTransition.slideTransition,
        nextScreen: Homescreen(),
        duration: 2500,
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}
