import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Style {
  static const Color bgColor = Color(0xff1e1e1e);
  static const Color secondryColor = Color(0xffAC1313);
  static const Color primraryColor = Color(0xff141414);
  static const Color headingColor = Colors.white;
  static const Color textColor = Color(0xff515467);
  static const double borderRadiusExtreme = 50;
  static const double borderRadiusLight = 10;
  static FontWeight getFontWeight(String style) {
    Map<String, FontWeight> weights = {
      'thin': FontWeight.w100,
      'extralight': FontWeight.w200,
      'light': FontWeight.w300,
      'regular': FontWeight.w400,
      'medium': FontWeight.w500,
      'semibold': FontWeight.w600,
      'bold': FontWeight.w700,
      'extrabold': FontWeight.w800,
      'black': FontWeight.w900
    };
    if(weights.containsKey(style)){
      return weights[style];
    }else{return weights['regular'];}
  }
  static TextStyle logoTextStyle = TextStyle(
    color: Style.headingColor,
    fontWeight: Style.getFontWeight('semibold'),
  );
  static TextStyle customContainerSectionTitleTextStyle = TextStyle(
      fontWeight: Style.getFontWeight('bold'),
      color: Style.headingColor,
      fontSize: 13
  );

  static TextStyle headerStockNameTextStyle = TextStyle(
      fontWeight: Style.getFontWeight('black'),
      color: Style.headingColor,
      fontSize: 35);
  static TextStyle headerCompanyNameTextStyle = TextStyle(
      fontWeight: Style.getFontWeight('thin'),
      color: Style.headingColor,
      fontSize: 18);
  static TextStyle stockStatusPriceTextStyle = TextStyle(fontWeight: Style.getFontWeight('bold'),color: Style.headingColor,fontSize: 16);
  static TextStyle stockStatusPriceVariationTextStyle = TextStyle(fontWeight: Style.getFontWeight('regular'),color: Style.headingColor,fontSize: 15);
}