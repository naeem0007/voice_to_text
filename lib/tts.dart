import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTS() {
    tts.setLanguage("bn-BD");
    tts.setLanguage("en-US");
  }

  static speak(String text) async {
    tts.setStartHandler(() {
      print("TTS IS STARTED");
    });

    tts.setCompletionHandler(() {
      print("COMPLETED");
    });
    await tts.awaitSpeakCompletion(true);
    tts.speak(text);
  }
}
