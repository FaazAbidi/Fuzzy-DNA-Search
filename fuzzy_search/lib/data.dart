import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_search/demo_dna.dart';
import 'package:fuzzy_search/index_information.dart';
import 'package:fuzzy_search/result_graph_data.dart';
import 'package:fuzzy_search/score_tiles.dart';
import 'package:fuzzy_search/style.dart' as localStyle;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as media;
import 'package:dio/dio.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Data {
  var result;
  String dnaSequence;
  String pattern;
  int marker = -1;
  List<ResultGraphData> graphData=[];
  List<CodeScoreTile> codeScoreTiles = [];
  ResultRuntimeTile resultRuntimeTile;
  String currentScore;


  TextStyle _textStyle = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
  TextStyle _highlightedTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: localStyle.Style.secondryColor);


  Data.fromCustom(
      this.dnaSequence,
      this.pattern
      );

  Data.fromPreloaded(
      this.marker,
      this.pattern
      );


  void changeScore(String newScore){
    currentScore=newScore;
  }



  Widget highlightedContainer (String pattern) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(bottom:10.0),
        child: Container(
          child: Center(child: Text(pattern,style: _highlightedTextStyle,)),
        ),
      )
    );
  }


  Future<http.Response> sendRequestForPreLoaded(int marker) async {
    String url = 'http://127.0.0.1:5000';
    Response response;
    Map<String, dynamic> headers =  {
      "Access-Control-Allow-Origin": "*"
    };
    var dio = Dio();
    dio.options.baseUrl = url;
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    FormData formData = FormData.fromMap({
      "marker" : marker,
      "substring" : pattern
    });

    response = await dio.post(
        "/preloaded",
        data: formData,
        options: Options(method: "POST",
            responseType: ResponseType.json ,
            headers: {"Access-Control-Allow-Origin" : "*", "Content-Type": "application/json"},
            contentType: Headers.formUrlEncodedContentType
        )
    );
    print(response.statusCode);
    result = jsonDecode(response.toString());
  }

  Future<http.Response> sendRequestWithCustom() async {
    print("in");
    String url = 'http://127.0.0.1:5000';
    Response response;
    Map<String, dynamic> headers =  {
    "Access-Control-Allow-Origin": "*"
    };
    var dio = Dio();
    dio.options.baseUrl = url;
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    FormData formData = FormData.fromMap({
      "substring" : pattern,
      "file": MultipartFile.fromString(kdnaRaw, filename:"demo_dna", contentType: media.MediaType("application", "json")),
      // "file": http.MultipartFile.fromPath("text_data", "indexes/test_data.txt"),
    });

    response = await dio.post(
        "/search",
      data: formData,
      options: Options(method: "POST",
          responseType: ResponseType.json ,
          headers: {"Access-Control-Allow-Origin" : "*", "Content-Type": "application/json"},
          contentType: Headers.formUrlEncodedContentType
          )
    );
    print("sending");
    print(response);
    result = jsonDecode(response.toString());
    print(result);
  }

  void changeMarker (int m) {
    marker = m;
  }

  List<IndexInformation> _getIndexInformation(List<List<int>> indexes){
    List<IndexInformation> indexInformation = [];
    for(List<int> i in indexes){
      indexInformation.add(IndexInformation(instance: dnaSequence.substring(i[0],i[1]),startIndex: i[0],endIndex: i[1]));
    }
    return indexInformation;
  }


  getResults() async {
    if (marker == -1) {
      await sendRequestWithCustom();
    } else {
      await sendRequestForPreLoaded(marker);
    }
    currentScore=pattern.length.toString();
    Map<String,List<List<int>>> scores={};
    result.forEach((key,value){
      if(key!='-1'){
        scores[key]=value;
      }else{
        resultRuntimeTile = ResultRuntimeTile(characterCount: dnaSequence.length,fileSize: '${(dnaSequence.length/1000).toStringAsFixed(3)} KB',queryTime: '${(value*1000).toStringAsFixed(3)} ms');
      }
    });

    scores.forEach(
     (key,value){
      graphData.add(ResultGraphData(int.parse(key),value.length));
      codeScoreTiles.add(
        CodeScoreTile(
          score: key,
          title:'score : $key',
          count: value.length,
          indexes: _getIndexInformation(value),
        )
      );
     });

  }

  List<Widget> getDnaTextWidgets() {
    List<dynamic> indexes = result[currentScore];
    List<Widget> dnaTextWidgets = [];
    for (int i = 0; i < indexes.length; i++) {
      if (i == 0) {
        dnaTextWidgets.add(Text(dnaSequence.substring(0, indexes[i][0]).toUpperCase(),style: _textStyle,));
        dnaTextWidgets.add(highlightedContainer(dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase()));
      } else if (i == indexes.length - 1) {
        dnaTextWidgets.add(
            Text( dnaSequence.substring(indexes[i - 1][1], indexes[i][0]).toUpperCase(),style: _textStyle,));
        dnaTextWidgets.add(highlightedContainer(dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase()));
        dnaTextWidgets.add(
            Text(dnaSequence.substring(indexes[i][1], dnaSequence.length).toUpperCase(),style: _textStyle,));
      } else {
        dnaTextWidgets.add(
            Text( dnaSequence.substring(indexes[i - 1][1], indexes[i][0]).toUpperCase(),style: _textStyle,));
        dnaTextWidgets.add(highlightedContainer(dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase()));
      }

    }
    print(dnaTextWidgets.length);
    return dnaTextWidgets;
  }
}