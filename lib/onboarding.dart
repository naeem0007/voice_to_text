import 'package:flutter/material.dart';
import 'package:voice_to_text/Image%20Generator/img_home_screen.dart';
import 'package:voice_to_text/colors.dart';
import 'package:voice_to_text/Chat%20GPT/speechscreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(
                  height: 70,
                ),
                const SizedBox(
                  height: 50,
                  child: Text(
                    "Welcome to AI Universe",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontFamily: poppinsBold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: chatbgColor, width: 3)),
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      "assets/aibg.png",
                      height: 200,
                      width: 150,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SpeechScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: bgColorLight,

                        // border: Border.all(color: chatbgColor),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "Chat GPT",
                      style: TextStyle(
                          fontFamily: poppinsBold,
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ImageScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: bgColorBlue,
                        border: Border.all(color: bgColor),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "Dall E",
                      style: TextStyle(
                          fontFamily: poppinsBold,
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
