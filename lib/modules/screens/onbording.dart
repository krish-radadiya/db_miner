import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;
  Color backgroundColor;
  UnbordingContent({
    required this.image,
    required this.title,
    required this.discription,
    required this.backgroundColor,
  });
}

// Created By Flutter Baba
List<UnbordingContent> contentsList = [
  UnbordingContent(
    backgroundColor: const Color(0xffF0CF69),
    title: "Information is the resolution of uncertainty.",
    image: 'assets/splash_screen/Mention-rafiki.svg',
    discription:
        "Information defines your personality, your memories, your skills.",
  ),
  UnbordingContent(
    backgroundColor: const Color(0xffB7ABFD),
    title: 'Information defines your personality, your memories, your skills.',
    image: 'assets/splash_screen/Mention-bro.svg',
    discription: " whereas knowledge can be acquired by thinking.",
  ),
  UnbordingContent(
    backgroundColor: const Color(0xffEFB491),
    title: 'To live effectively is to live with adequate information.',
    image: 'assets/splash_screen/Mention-pana.svg',
    discription:
        "Information defines your personality, your memories, your skills.",
  ),
  UnbordingContent(
    backgroundColor: const Color(0xff95B6FF),
    title: 'Information defines your personality, your memories, your skills.',
    image: 'assets/splash_screen/Mention-amico.svg',
    discription:
        "Information defines your personality, your memories, your skills.",
  ),
];
