import 'package:flutter/material.dart';
import 'package:voice_to_text/Chat%20GPT/tts.dart';

class TTSScreen extends StatelessWidget {
  const TTSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text To Speech"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () {
                TextToSpeech.speak(textController.text);
              },
              child: const Text("Speak"))
        ],
      ),
    );
  }
}
