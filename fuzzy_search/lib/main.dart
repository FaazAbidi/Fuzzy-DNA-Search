import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuzzy Search DNA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _height = 200;
  double _width = 200;

  dnaStrand () {

    return MouseRegion(
      onHover: (details) {
        print("hover");
        setState(() {
          _height = 400;
          _width = 400;
        });
      },
      child: AnimatedContainer(
          height: 150,
          width: 150,
          duration: Duration(seconds: 1),
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: ),
          child: Image.asset("dnastrand.png"),
        ),
        curve: Curves.bounceIn,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(45, 0, 0, 1),
      body: Stack(
        children: [
          Stack(
            children: [
              dnaStrand()
            ],
          )
        ],
      ),
    );
  }
}
