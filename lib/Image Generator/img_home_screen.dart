import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:screenshot/screenshot.dart';

import 'package:voice_to_text/Image%20Generator/download_share_img.dart';
import 'package:voice_to_text/Image%20Generator/img_api_services.dart';
import 'package:voice_to_text/Image%20Generator/img_art_screen.dart';
import 'package:voice_to_text/colors.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var sizes = ["Small", "Medium", "Large"];
  var values = ["256x256", "512x512", "1024x1024"];
  String? dropValue;
  var textController = TextEditingController();
  String image = "";
  var isLoaded = true;
  var isLoading = false;
  ScreenshotController screenshotController = ScreenshotController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.navigate_before_sharp,
                color: whitecolor,
                size: 28,
              )),
          backgroundColor: bgColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.art_track_rounded,
                  size: 34,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArtScreen()));
                },
              ),
            ),
          ],
          centerTitle: true,
          title: const Text(
            "AI Image Generator",
            style: TextStyle(fontFamily: poppinsBold, color: whitecolor),
          )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                            color: whitecolor,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                          focusNode: focusNode,
                          controller: textController,
                          decoration: InputDecoration(
                              hintText: "eg: A Monkey on the Moon",
                              hintStyle: TextStyle(
                                  color: bgColor.withOpacity(0.8),
                                  fontFamily: poppinsRegular,
                                  fontSize: 15),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: const Icon(
                                Icons.expand_more_rounded,
                                color: btnColor,
                              ),
                              value: dropValue,
                              hint: const Text(
                                "Select Size",
                                style: TextStyle(
                                    color: bgColor, fontFamily: poppinsRegular),
                              ),
                              items: List.generate(
                                  sizes.length,
                                  (index) => DropdownMenuItem(
                                        value: values[index],
                                        child: Text(
                                          sizes[index],
                                          style: const TextStyle(
                                              fontFamily: poppinsSemiBold),
                                        ),
                                      )),
                              onChanged: (value) {
                                setState(() {
                                  dropValue = value.toString();
                                });
                              })),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                    onTap: () async {
                      if (textController.text.isNotEmpty &&
                          dropValue!.isNotEmpty) {
                        setState(() {
                          isLoaded = true;
                          isLoading = true;
                        });
                        image = await Api.generateImage(
                            textController.text, dropValue!);
                        setState(() {
                          isLoaded = false;
                          isLoading = false;
                        });
                      } else {
                        isLoading = false;
                        isLoaded = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Please Enter Anything and Select Size")));
                      }
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
                        "Generate",
                        style: TextStyle(
                            fontFamily: poppinsBold,
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(
                  height: 8,
                )
              ],
            )),
            Expanded(
                flex: 4,
                child: Stack(children: [
                  Visibility(
                    visible: isLoaded,
                    child: isLoading
                        ? const Center(
                            child: SpinKitWave(
                            color: btnColor,
                            type: SpinKitWaveType.center,
                          ))
                        : Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: whitecolor),
                            child: const Text(
                              "Describe your Favourite Image and Size!",
                              style: TextStyle(
                                  fontFamily: poppinsBold,
                                  color: chatbgColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                  Visibility(
                    visible: !isLoaded,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Screenshot(
                              controller: screenshotController,
                              child: Image.network(
                                image,
                                fit: BoxFit.contain,
                              ),
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                  gradient: bgColorBlue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: ElevatedButton.icon(
                                  icon: const Icon(Icons.download),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: Colors.transparent),
                                  onPressed: () {
                                    downloadImg(context);
                                  },
                                  label: const Text(
                                    "Download",
                                    style: TextStyle(
                                        fontFamily: poppinsSemiBold,
                                        fontSize: 18),
                                  )),
                            )),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                  gradient: bgColorBlue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: ElevatedButton.icon(
                                  icon: const Icon(Icons.share),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: Colors.transparent),
                                  onPressed: () async {
                                    shareImage(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Image Shared")));
                                  },
                                  label: const Text(
                                    "Share",
                                    style: TextStyle(
                                        fontFamily: poppinsSemiBold,
                                        fontSize: 18),
                                  )),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ])),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Developed By Naeem",
                style: TextStyle(color: whitecolor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
