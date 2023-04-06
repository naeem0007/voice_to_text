import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_to_text/colors.dart';
import 'package:voice_to_text/splash_screen.dart';

import 'package:voice_to_text/Chat%20GPT/tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  TextToSpeech.initTTS();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      title: "Voice to Text",
      theme: ThemeData(
          fontFamily: poppinsSemiBold,
          appBarTheme:
              const AppBarTheme(color: Colors.transparent, elevation: 0.0)),
    );
  }
}
