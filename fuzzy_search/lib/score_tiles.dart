import 'package:flutter/material.dart';
import 'package:fuzzy_search/index_information.dart';
import 'package:fuzzy_search/style.dart';

import 'data.dart';

class CodeScoreTile extends StatelessWidget {
  String title;
  String score;
  int count;
  List<IndexInformation> indexes;
  String dnaSequence;

  CodeScoreTile({
    Key key,
    this.title,
    this.count,
    this.indexes,
    this.dnaSequence,
    this.score,
  }) : super(key: key);


  List<Widget> getIndexInformation(){
    List<Widget> _indexInfoWidgets = [];
    for(IndexInformation index in indexes){
      _indexInfoWidgets.add(
          GestureDetector(onLongPress: (){
            print('long press detect');
            Data.itemScrollController.scrollTo(index: 2*index.oIndex+1, duration: Duration(seconds: 1));
          },child: SubTile(qtyName:index.instance,qty:'Index : ${index.startIndex} - ${index.endIndex}',))
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
