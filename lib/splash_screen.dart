import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:voice_to_text/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        centered: true,
        splashIconSize: 160,
        splash: Image.asset(
          "assets/bot.png",
          width: 200,
          height: 200,
        ),
        nextScreen: const OnboardingScreen(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.white,
        duration: 2000,
        animationDuration: const Duration(seconds: 3),
      ),
    );
  }
}
