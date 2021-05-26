import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_search/demo_dna.dart';
import 'data.dart';
import 'graph.dart';
import 'index_information.dart';
import 'style.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<Widget> dnaTextWidgets=[];
  Data mainData;
  FilePickerResult dnaSequence;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    mainData = Data(kdnaRaw);
    mainData.getResults();
    dnaTextWidgets = mainData.getDnaTextWidgets('97');
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
              padding: EdgeInsets.all(30.0),
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
                        child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Scrollbar(
                            controller: _scrollController,
                            isAlwaysShown: true,
                            child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: dnaTextWidgets.length,
                              itemBuilder: (context,index){
                                return dnaTextWidgets[index];
                              },
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
                                      ResultRuntimeTile(characterCount: 8000000,fileSize: '400 MB',queryTime: '0.8s',),
                                      CodeScoreTile(title:"score : 100", count: 23, indexes : [IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AHT',startIndex: 18,endIndex: 21),IndexInformation(instance: 'AHT',startIndex: 20,endIndex: 23),IndexInformation(instance: 'AHT',startIndex: 40,endIndex: 43),IndexInformation(instance: 'AHT',startIndex: 43,endIndex: 46)]),
                                      CodeScoreTile(title:"score : 90", count: 23, indexes : [IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AHT',startIndex: 18,endIndex: 21),IndexInformation(instance: 'AHT',startIndex: 20,endIndex: 23),IndexInformation(instance: 'AHT',startIndex: 40,endIndex: 43),IndexInformation(instance: 'AHT',startIndex: 43,endIndex: 46)]),
                                      CodeScoreTile(title:"score : 80", count: 23, indexes : [IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AGT',startIndex: 10,endIndex: 13),IndexInformation(instance: 'AHT',startIndex: 18,endIndex: 21),IndexInformation(instance: 'AHT',startIndex: 20,endIndex: 23),IndexInformation(instance: 'AHT',startIndex: 40,endIndex: 43),IndexInformation(instance: 'AHT',startIndex: 43,endIndex: 46)]),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(child:Graph()),
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

class ResultRuntimeTile extends StatelessWidget {
  int characterCount;
  String fileSize;
  String queryTime;

  ResultRuntimeTile({
    Key key,
    this.characterCount,
    this.fileSize,
    this.queryTime,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Style.secondryColor,
      child: ExpansionTile(
        title: Text(
          'Runtime Analysis',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500,color: Colors.white),
        ),
        children:[
          SubTile(qtyName: 'Character Count',qty: characterCount.toString(),),
          SubTile(qtyName: 'File Size',qty: fileSize,),
          SubTile(qtyName: 'Query Time',qty: queryTime,)
        ],
      ),
    );
  }
}


class CodeScoreTile extends StatelessWidget {
  String title;
  int count;
  List<IndexInformation> indexes;
  String dnaSequence;

  CodeScoreTile({
    Key key,
    this.title,
    this.count,
    this.indexes,
    this.dnaSequence,
  }) : super(key: key);

  List<Widget> getIndexInformation(){
    List<Widget> _indexInfoWidgets = [];
    for(IndexInformation index in indexes){
     _indexInfoWidgets.add(
       SubTile(qtyName:index.instance,qty:'Indexes : ${index.startIndex} - ${index.endIndex}')
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



class SubTile extends StatelessWidget {
  String qtyName;
  String qty;
  SubTile({this.qty,this.qtyName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: Row(
        children: [
          Text(
            qtyName,
            style: TextStyle(fontSize: 13.0,color: Colors.white,fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            qty,
            style: TextStyle(fontSize: 13.0,color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

