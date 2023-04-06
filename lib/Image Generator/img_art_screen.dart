import 'dart:io';

import 'package:flutter/material.dart';
import 'package:voice_to_text/colors.dart';

class ArtScreen extends StatefulWidget {
  const ArtScreen({super.key});

  @override
  State<ArtScreen> createState() => _ArtScreenState();
}

class _ArtScreenState extends State<ArtScreen> {
  List imgList = [];
  getImage() async {
    final directory = Directory("storage/emulated/0/AI Image");
    imgList = directory.listSync();
    // ignore: avoid_print
    print(imgList);
  }

  popImage(filepath) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                    color: whitecolor, borderRadius: BorderRadius.circular(12)),
                child: Image.file(
                  filepath,
                  fit: BoxFit.cover,
                ),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "My Arts",
            style: TextStyle(fontFamily: poppinsBold, color: whitecolor),
          )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 300,
            crossAxisCount: 2,
          ),
          itemCount: imgList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => popImage(imgList[index]),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Image.file(
                  imgList[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
