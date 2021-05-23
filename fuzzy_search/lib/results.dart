import 'package:dynamic_text_highlighting/dynamic_text_highlighting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_search/index_information.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fuzzy_search/processingDNA.dart';

import 'style.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  FilePickerResult dnaSequence;
  TextStyle _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );
  TextStyle _highlightedTextStyle = TextStyle(fontSize: 30, color: Colors.grey);
  String _dnaText;
  Map<String, HighlightedWord> words;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String _githubUrl = "https://github.com/FaazAbidi/Fuzzy-DNA-Search/blob/main/fuzzy_search/README.md";

    return Material(
      type: MaterialType.transparency,
      child: Container(
        child: Stack(
          children: [
            Hero(
              tag: 'dna-sq',
              child: Padding(
                padding: EdgeInsets.only(left: _width * 0.001),
                child: Opacity(
                  opacity: 0.35,
                  child: Container(
                    alignment: Alignment.centerRight,
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(image: DecorationImage(scale: 10, image: AssetImage("bg.png"), fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(55.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Style.primraryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      //color: Colors.black54,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                ProcessingDNA().getDnaText()
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Results',style: TextStyle(fontSize: 20,color:Colors.white),textAlign: TextAlign.start,),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CodeScoreTile(title:"Perfect Match | score : 100", count: 23, indexes : [IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AHT',startIndex: 18,endIndex: 21),IndexInformation(instance: 'AHT',startIndex: 20,endIndex: 23),IndexInformation(instance: 'AHT',startIndex: 40,endIndex: 43),IndexInformation(instance: 'AHT',startIndex: 43,endIndex: 46)]),
                                      CodeScoreTile(title:"score : 90", count: 23, indexes : [IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AHT',startIndex: 18,endIndex: 21),IndexInformation(instance: 'AHT',startIndex: 20,endIndex: 23),IndexInformation(instance: 'AHT',startIndex: 40,endIndex: 43),IndexInformation(instance: 'AHT',startIndex: 43,endIndex: 46)]),
                                      CodeScoreTile(title:"score : 80", count: 23, indexes : [IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AHT',startIndex: 18,endIndex: 21),IndexInformation(instance: 'AHT',startIndex: 20,endIndex: 23),IndexInformation(instance: 'AHT',startIndex: 40,endIndex: 43),IndexInformation(instance: 'AHT',startIndex: 43,endIndex: 46)]),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(color: Colors.green),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CodeScoreTile extends StatelessWidget {
  String title;
  int count;
  List<IndexInformation> indexes;
  CodeScoreTile({
    Key key,
    this.title,
    this.count,
    this.indexes,
  }) : super(key: key);

  List<Widget> getIndexInformation(){
    List<Widget> _indexInfoWidgets = [];
    for(IndexInformation index in indexes){
     _indexInfoWidgets.add(
       Padding(
         padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
         child: Row(
           children: [
             Text(
               index.instance,
               style: TextStyle(fontSize: 13.0,color: Colors.white,fontWeight: FontWeight.bold),
             ),
             Spacer(),
             Text(
               'Indexes : ${index.startIndex} - ${index.endIndex}',
               style: TextStyle(fontSize: 13.0,color: Colors.white,fontWeight: FontWeight.bold),
             ),
           ],
         ),
       ),
     );
    }
    return _indexInfoWidgets;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Style.secondryColor,
    child: ExpansionTile(
      title: Text(
      title,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500,color: Colors.white),
      ),
    trailing: Text(
      '(${count})',
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500,color: Colors.white),
    ),
    children:getIndexInformation(),
    ),
    );
  }
}




