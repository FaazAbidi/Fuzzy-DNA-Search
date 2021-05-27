import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:flutter/rendering.dart';
import 'package:fuzzy_search/results.dart';
import 'package:fuzzy_search/style.dart';

import 'home.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuzzy Search DNA',
      theme: ThemeData(
        primaryColor: Style.primraryColor,
        accentColor:  Style.secondryColor,
        unselectedWidgetColor: Colors.white,
        fontFamily: "Poppins",
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Scaffold(backgroundColor: Style.bgColor ,body: FuzzySearchHome(
      )),
    );
  }
}

