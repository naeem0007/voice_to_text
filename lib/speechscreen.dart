import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_to_text/api_services.dart';
import 'package:voice_to_text/chat_model.dart';
import 'package:voice_to_text/colors.dart';
import 'package:voice_to_text/threedots.dart';
import 'package:voice_to_text/tts.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  var text = "Hold the Button and Start Speaking or send some message";
  var isListening = false;
  var isTyping = false;
  SpeechToText speechToText = SpeechToText();
  final List<ChatMessage> messages = [];

  final TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  var scrollController = ScrollController();

  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.sort_rounded),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Voice Assistant",
          style: TextStyle(fontWeight: FontWeight.w600, color: textColor),
        ),
        flexibleSpace:
            Container(decoration: const BoxDecoration(gradient: bglightBlue)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        color: isListening ? Colors.black87 : Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 11),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.658,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          gradient: bgColorDark,
                          borderRadius: BorderRadius.circular(12)),
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          var chat = messages[index];
                          return chatBubble(
                              chattext: chat.text, type: chat.type);
                        },
                      ),
                    ),
                  ),
                  if (isTyping) const ThreeDots(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: TextField(
                            focusNode: focusNode,
                            controller: controller,
                            decoration: const InputDecoration.collapsed(
                                hintText: "Send a Message"),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            if (controller.text.isNotEmpty) {
                              setState(() {
                                isTyping = true;
                                messages.add(ChatMessage(
                                    text: controller.text,
                                    type: ChatMessageType.user));
                                focusNode.unfocus();
                              });

                              var input = await ApiServices.sendMeaasage(
                                  controller.text);
                              input = input.trim();
                              controller.clear();

                              setState(() {
                                isTyping = false;
                                messages.add(ChatMessage(
                                    text: input, type: ChatMessageType.bot));
                              });
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                TextToSpeech.speak(input);
                              });

                              controller.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content:
                                          Text("Please Ask me a Question")));
                            }
                          },
                          icon: const Icon(Icons.send)),
                      AvatarGlow(
                        endRadius: 40,
                        animate: isListening,
                        glowColor: Colors.teal,
                        repeat: true,
                        duration: const Duration(seconds: 1),
                        repeatPauseDuration: const Duration(milliseconds: 50),
                        showTwoGlows: true,
                        shape: BoxShape.circle,
                        child: GestureDetector(
                          onTapDown: (details) async {
                            if (!isListening) {
                              var available = await speechToText.initialize();
                              if (available) {
                                setState(() {
                                  isListening = true;

                                  speechToText.listen(onResult: (result) {
                                    setState(() {
                                      text = result.recognizedWords;
                                    });
                                  });
                                });
                              }
                            }
                          },
                          onTapUp: (details) async {
                            setState(() {
                              isTyping = true;
                              isListening = false;
                            });
                            speechToText.stop();
                            if (text.isNotEmpty &&
                                text !=
                                    "Hold the Button and Start Speaking or send some message") {
                              messages.add(ChatMessage(
                                  text: text, type: ChatMessageType.user));
                              var msg = await ApiServices.sendMeaasage(text);
                              msg = msg.trim();

                              setState(() {
                                isTyping = false;
                                messages.add(ChatMessage(
                                    text: msg, type: ChatMessageType.bot));
                              });

                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                TextToSpeech.speak(msg);
                              });
                            } else {
                              isTyping = false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text("Please Speak Something")));
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                gradient: bglightBlue,
                                borderRadius: BorderRadius.circular(35)),
                            child: Icon(
                              isListening ? Icons.mic : Icons.mic_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Developed by Naeem",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatBubble({required chattext, required ChatMessageType? type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35), gradient: bglightBlue),
          child: type == ChatMessageType.bot
              ? Image.asset('assets/bot.png')
              : const Icon(
                  Icons.person_2_outlined,
                  color: Colors.white,
                ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              gradient: type == ChatMessageType.bot
                  ? bglightBlue
                  : const LinearGradient(colors: [
                      Colors.white,
                      Color.fromARGB(255, 217, 183, 183)
                    ]),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(chattext,
                    textStyle: TextStyle(
                        color: type == ChatMessageType.bot
                            ? textColor
                            : chatbgColor,
                        fontSize: 15,
                        fontWeight: type == ChatMessageType.bot
                            ? FontWeight.w600
                            : FontWeight.w400),
                    speed: const Duration(milliseconds: 50))
              ],
              isRepeatingAnimation: false,
              repeatForever: false,
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
          ),
        ),
      ],
    );
  }
}
