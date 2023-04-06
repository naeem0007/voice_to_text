import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTS() {
    tts.setLanguage("bn-BD");
    tts.setLanguage("en-US");
  }

  static speak(String text) async {
    tts.setStartHandler(() {
      // ignore: avoid_print
      print("TTS IS STARTED");
    });

    tts.setCompletionHandler(() {
      // ignore: avoid_print
      print("COMPLETED");
    });
    await tts.awaitSpeakCompletion(true);
    tts.speak(text);
  }
}
