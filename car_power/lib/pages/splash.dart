import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 120.0,
            child: Image.asset(
              'assets/coche_icono.png',
              width: 200,
            ),
          ),
          const Text(
            "Car Power",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
      backgroundColor: Colors.redAccent,
      nextScreen: const MyHomePage(title: "hola"),
      splashIconSize: 300,
      duration: 4000,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
