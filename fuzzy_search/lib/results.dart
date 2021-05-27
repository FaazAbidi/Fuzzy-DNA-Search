import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_search/demo_dna.dart';
import 'package:fuzzy_search/result_graph_data.dart';
import 'package:fuzzy_search/score_tiles.dart';
import 'data.dart';
import 'graph.dart';
import 'index_information.dart';
import 'style.dart';

class Results extends StatefulWidget {
  Data data;

  Results(this.data);

  @override
  _ResultsState createState() => _ResultsState(data);
}


class _ResultsState extends State<Results> {
  List<Widget> dnaTextWidgets=[];
  Data mainData;
  FilePickerResult dnaSequence;
  final ScrollController _scrollController = ScrollController();

  _ResultsState(this.mainData);



  @override
  void initState() {
    dnaTextWidgets = mainData.getDnaTextWidgets();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

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
                        child: Padding(
                          padding: EdgeInsets.only(top: 25,bottom: 25,right: 25),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Results',style: TextStyle(fontSize: 20,color:Colors.white),textAlign: TextAlign.start,),
                                SizedBox(height: 5,),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        mainData.resultRuntimeTile,
                                        for(CodeScoreTile scoreTile in mainData.codeScoreTiles)
                                          GestureDetector(child: scoreTile,onDoubleTap: (){
                                            setState(() {
                                            print(scoreTile.score);
                                            mainData.changeScore(scoreTile.score);
                                            dnaTextWidgets=mainData.getDnaTextWidgets();
                                          });}
                                          ,)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(child:Padding(
                                    padding: EdgeInsets.only(top:10),
                                    child: Graph(resultGraphData: mainData.graphData,),
                                  )),
                                )
                              ],
                            ),
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
