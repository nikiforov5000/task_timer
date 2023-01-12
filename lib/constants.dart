import 'dart:math';

import 'package:flutter/material.dart';

const kEnabledTaskTitleTextStyle = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 25,
);

TextStyle kDisabledTaskTitleTextStyle = kEnabledTaskTitleTextStyle.copyWith(
  // decoration: TextDecoration.lineThrough,
  color: kSemiLightGreyColor,
);

const kDarkGreyColor = Color(0xff202020);
const kSemiDarkGreyColor = Color(0xff323232);
const kMidGreyColor = Color(0xff3b3b3b);
const kSemiLightGreyColor = Color(0xff4b4b4b);
const kLightGreyColor = Color(0xffeeeeee);

const kBaseChartColor = kSemiLightGreyColor;
const kEnabledCenterDiscColor = Color(0xff889090);
const kDisabledCenterDiscColor = Color(0xff666363);

const kGradientList = <List<Color>>[
  [
    Colors.greenAccent,
    Colors.green,
  ]
];

const kColorList = <Color>[
  Color(0xffaa8888),
  Color(0xffaa8844),
];
const kChartColorsList = [
  Color(0xff9C59B1),

];

const kPiechartCenterTextStyle = TextStyle();

class TaskColors {
  static Color getRandomColor() {
    Random random = Random();
    List<int> colorComponents = [
      random.nextInt(155) + 100, // RED
      random.nextInt(155) + 100, // GREEN
      random.nextInt(155) + 100   // BLUE
    ];

    colorComponents[random.nextInt(3)] %= 50;

    return Color.fromARGB(
      255,
      colorComponents[0],
      colorComponents[1],
      colorComponents[2],
    );
  }
}

BoxShadow kCenterDiscShadow = BoxShadow(
    color: Colors.black38,
    offset: Offset(5, 5),
    blurRadius: 18,
);