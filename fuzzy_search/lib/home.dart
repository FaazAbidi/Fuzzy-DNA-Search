import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:flutter/rendering.dart';
import 'package:fuzzy_search/style.dart';
import 'package:url_launcher/url_launcher.dart';


class FuzzySearchHome extends StatefulWidget {

  @override
  _FuzzySearchHomeState createState() => _FuzzySearchHomeState();
}

class _FuzzySearchHomeState extends State<FuzzySearchHome>  {

  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _bgSize = 1.0;
    String _githubUrl = "https://github.com/FaazAbidi/Fuzzy-DNA-Search/blob/main/fuzzy_search/README.md";

    Widget menuButton (String text, {VoidCallback onTap}) {
      return InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: "Poppins",),
        ),
      );
    }


    void _launchURL() async =>
        await canLaunch(_githubUrl) ? await launch(_githubUrl) : throw 'Could not launch $_githubUrl';


     showAboutDialog () {
       return showDialog(context: context, builder: (BuildContext context) {
         return Dialog(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15),
           ),
           elevation: 2,
           backgroundColor: Colors.white,
           child: Container(
               height: _height*0.65,
               width: _width * 0.45
           ),
         );
       },
       );
     }

       return Scaffold(
         backgroundColor: Color.fromRGBO(40,40,40,1),
         body: Stack(
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 450.0),
               child: Opacity(
                 opacity: 0.35,
                 child: AnimatedContainer(
                   duration: Duration(seconds: 2),
                   alignment: Alignment.centerRight,
                   constraints: BoxConstraints.expand(),
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           scale: 5,
                           image: AssetImage("bg.png"),
                           fit: BoxFit.cover)),
                 ),
               ),
             ),
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Padding(
                   padding:  EdgeInsets.only(top: _height*0.07),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(left: _width*0.03),
                         child: Container(
                           constraints: BoxConstraints.expand(height: _height*0.1,width: _width*0.15),
                           decoration: BoxDecoration(
                               image: DecorationImage(
                                   image: AssetImage("fuzzydna.png"),
                                   fit: BoxFit.cover)),
                         ),
                       ),
                       Padding(
                         padding:  EdgeInsets.only(right: _width*0.065),
                         child: Row(
                           children: [
                             menuButton("About", onTap: () { showAboutDialog(); }),
                             SizedBox(width: _width*0.03,),
                             menuButton("GitHub", onTap:  () { _launchURL(); })
                           ],
                         ),
                       )

                     ],
                   ),
                 ),
                 // SizedBox(height: _height*0.15,),
                 Padding(
                   padding: EdgeInsets.only(left: _width*0.05, right: _width*0.065),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         height: _height*0.35,
                         width: _width*0.25,
                         decoration: BoxDecoration(
                           color: Style.primraryColor,
                           borderRadius: BorderRadius.all(Radius.circular(15)),boxShadow: [
                           BoxShadow(
                             color: Colors.black,
                             spreadRadius: 1,
                             blurRadius: 5,
                             offset: Offset(0, 3), // changes position of shadow
                           ),
                         ],


                         ),
                         child: Padding(
                           padding:  EdgeInsets.symmetric(vertical: _height*0.04),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   IconButton(
                                       iconSize: _width*0.03,
                                       icon: Icon(Icons.add_circle_rounded, color: Colors.white,),
                                       onPressed: () {}),
                                   Column(
                                     children: [
                                       Text("Add Your Sequence", style: TextStyle(color: Colors.white, fontSize: _width*0.012, fontWeight: FontWeight.w300, height: 1)),
                                       InkWell(
                                         child: Text("Or Generate A Random", style: TextStyle(color: Colors.white, fontSize: _width*0.01, fontWeight: FontWeight.w300, height: 1.5)),
                                         onTap: () {},
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                               SizedBox(height: _height*0.03,),
                               Container(
                                   width: _width*0.21,
                                   height: 40,
                                   child: TextField(
                                     textAlign: TextAlign.justify,
                                     textCapitalization: TextCapitalization.characters,
                                     cursorColor: Style.secondryColor,
                                     decoration: InputDecoration(
                                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                         fillColor: Colors.white,
                                         filled: true,
                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                         contentPadding: EdgeInsets.only(bottom: 8, left: 10, right: 10),
                                         hintText: "Enter sequence"
                                     ),
                                   )
                               ),
                               SizedBox(height: _height*0.03,),
                               InkWell(
                                 onTap: () {},
                                 child: Container(
                                   width: _width*0.21,
                                   height: 40,
                                   child: Center(
                                     child: Text("Begin Processing", style: TextStyle(color: Colors.white, fontSize: _width*0.01, fontWeight: FontWeight.w300,),
                                     ),
                                   ),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                       color: Style.secondryColor
                                   ),
                                 ),
                               )
                             ],
                           ),
                         ),
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text("DNA", style: TextStyle(color: Colors.white, fontSize: _width*0.04, fontWeight: FontWeight.w800, height: 1)),
                           Text("PATTERN", style: TextStyle(color: Colors.white, fontSize: _width*0.04, fontWeight: FontWeight.w300, height: 1)),
                           Text("SEARCH", style: TextStyle(color: Colors.white, fontSize: _width*0.043, fontWeight: FontWeight.w300, height: 1)),
                           Text("Ultra efficient tool for DNA patterns and traits searching", style: TextStyle(color: Colors.white, fontSize: _width*0.012, fontWeight: FontWeight.w200)),
                         ],
                       ),
                     ],
                   ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Padding(
                       padding: EdgeInsets.only(left: _width*0.06, bottom: _height*0.035),
                       child: Text("Designed w/ love at HU", style: TextStyle(color: Colors.white, fontSize: _width*0.01, fontWeight: FontWeight.w300,)),
                     ),
                   ],
                 )
               ],
             ),
           ],
         ),
       );
     }
  }