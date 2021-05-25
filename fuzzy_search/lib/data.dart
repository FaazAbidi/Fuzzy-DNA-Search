import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fuzzy_search/demo_dna.dart';
import 'package:fuzzy_search/style.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Data {
  Map<String, List<List<int>>> result;
  String dnaSequence;
  TextStyle _textStyle = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
  TextStyle _highlightedTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Style.secondryColor);

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

  Future<http.Response> sendRequest(String pattern) async {
    String url = 'https://fm-index.herokuapp.com';
    Response response;
    Map<String, dynamic> headers =  {
    "Access-Control-Allow-Origin": "*"
    };
    var dio = Dio();
    dio.options.baseUrl = url;
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromString(kdnaRaw, filename:"demo_dna"),
      "substring" : pattern
    });
    response = await dio.post(
        "/search",
      data: formData,
      options: Options(headers: {"Access-Control-Allow-Origin" : "*"})
    );
    print(response.statusCode);
    print(response.data['100']);
  }

  Data(String d){
    dnaSequence=d;
  }
  void getResults(){

    result = {
      '77': [
        [0, 28],
        [1, 29],
        [2, 30],
        [3, 31],
        [4, 32],
        [5, 33],
        [6, 34],
        [7, 35],
        [8, 36],
        [173737, 173765],
        [173738, 173766],
        [173739, 173767],
        [173740, 173768],
        [173741, 173769],
        [173742, 173770],
        [173743, 173771],
        [173744, 173772],
        [173755, 173783],
        [173756, 173784],
        [173757, 173785],
        [173758, 173786],
        [173759, 173787],
        [173760, 173788],
        [173761, 173789],
        [173762, 173790],
        [173763, 173791]
      ],
      '80': [
        [0, 29],
        [1, 30],
        [2, 31],
        [3, 32],
        [4, 33],
        [5, 34],
        [6, 35],
        [7, 36],
        [173737, 173766],
        [173738, 173767],
        [173739, 173768],
        [173740, 173769],
        [173741, 173770],
        [173742, 173771],
        [173743, 173772],
        [173755, 173784],
        [173756, 173785],
        [173757, 173786],
        [173758, 173787],
        [173759, 173788],
        [173760, 173789],
        [173761, 173790],
        [173762, 173791]
      ],
      '83': [
        [0, 30],
        [1, 31],
        [2, 32],
        [3, 33],
        [4, 34],
        [5, 35],
        [6, 36],
        [173737, 173767],
        [173738, 173768],
        [173739, 173769],
        [173740, 173770],
        [173741, 173771],
        [173742, 173772],
        [173755, 173785],
        [173756, 173786],
        [173757, 173787],
        [173758, 173788],
        [173759, 173789],
        [173760, 173790],
        [173761, 173791]
      ],
      '86': [
        [0, 31],
        [1, 32],
        [2, 33],
        [3, 34],
        [4, 35],
        [5, 36],
        [173737, 173768],
        [173738, 173769],
        [173739, 173770],
        [173740, 173771],
        [173741, 173772],
        [173755, 173786],
        [173756, 173787],
        [173757, 173788],
        [173758, 173789],
        [173759, 173790],
        [173760, 173791]
      ],
      '88': [
        [0, 32],
        [1, 33],
        [2, 34],
        [3, 35],
        [4, 36],
        [173737, 173769],
        [173738, 173770],
        [173739, 173771],
        [173740, 173772],
        [173755, 173787],
        [173756, 173788],
        [173757, 173789],
        [173758, 173790],
        [173759, 173791]
      ],
      '91': [
        [0, 33],
        [1, 34],
        [2, 35],
        [3, 36],
        [173737, 173770],
        [173738, 173771],
        [173739, 173772],
        [173755, 173788],
        [173756, 173789],
        [173757, 173790],
        [173758, 173791]
      ],
      '94': [
        [0, 34],
        [1, 35],
        [2, 36],
        [173737, 173771],
        [173738, 173772],
        [173755, 173789],
        [173756, 173790],
        [173757, 173791]
      ],
      '97': [[18, 38], [5018, 5038], [10018, 10038], [15018, 15038], [19482, 19502], [24482, 24502], [29482, 29502], [34482, 34502], [38946, 38966], [43946, 43966], [48946, 48966], [53946, 53966], [58410, 58430], [63410, 63430], [68410, 68430], [73410, 73430], [77874, 77894], [82874, 82894], [87874, 87894], [92874, 92894], [97338, 97358], [102338, 102358], [107338, 107358], [112338, 112358], [116802, 116822], [121802, 121822], [126802, 126822], [131802, 131822], [136266, 136286], [141266, 141286], [146266, 146286], [151266, 151286], [155730, 155750], [160730, 160750], [165730, 165750], [170730, 170750], [175194, 175214], [180194, 180214], [185194, 185214], [190194, 190214], [194658, 194678], [199658, 199678], [204658, 204678], [209658, 209678], [214122, 214142], [219122, 219142], [224122, 224142], [229122, 229142], [233586, 233606], [238586, 238606], [243586, 243606], [248586, 248606], [253050, 253070], [258050, 258070], [263050, 263070], [268050, 268070], [272514, 272534], [277514, 277534], [282514, 282534], [287514, 287534], [291978, 291998], [296978, 296998], [301978, 301998], [306978, 306998], [311442, 311462], [316442, 316462], [321442, 321462], [326442, 326462], [330906, 330926], [335906, 335926], [340906, 340926], [345906, 345926], [350370, 350390], [355370, 355390], [360370, 360390], [365370, 365390], [369834, 369854], [374834, 374854], [379834, 379854], [384834, 384854], [389298, 389318], [394298, 394318], [399298, 399318], [404298, 404318], [408762, 408782], [413762, 413782], [418762, 418782], [423762, 423782], [428226, 428246], [433226, 433246], [438226, 438246], [443226, 443246], [447690, 447710], [452690, 452710], [457690, 457710], [462690, 462710], [472154, 472174], [477154, 477174], [482154, 482174], [491618, 491638], [496618, 496638], [501618, 501638], [511082, 511102], [516082, 516102], [521082, 521102], [530546, 530566], [535546, 535566], [540546, 540566], [550010, 550030], [555010, 555030], [560010, 560030], [569474, 569494], [574474, 574494], [579474, 579494], [588938, 588958], [593938, 593958], [598938, 598958], [605099, 605119]]
    };
  }
  List<Widget> getDnaTextWidgets(String score) {
    List<List<int>> indexes = result[score];
    List<Widget> dnaTextWidgets = [];

    for (int i = 0; i < indexes.length; i++) {
      if (i == 0) {
        dnaTextWidgets.add(Text(dnaSequence.substring(0, indexes[i][0]).toUpperCase(),style: _textStyle,));
        // dnaTextWidgets.add(Text(dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase(),
        //   style: _highlightedTextStyle,textAlign: TextAlign.center,));
        dnaTextWidgets.add(highlightedContainer(dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase()));
      } else if (i == indexes.length - 1) {
        dnaTextWidgets.add(
            Text(dnaSequence.substring(indexes[i][1], dnaSequence.length).toUpperCase(),style: _textStyle,));
      } else {
        dnaTextWidgets.add(
            Text( dnaSequence.substring(indexes[i - 1][1], indexes[i][0]).toUpperCase(),style: _textStyle,));
        // dnaTextWidgets.add(Text( dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase(),
        //   style: _highlightedTextStyle,textAlign: TextAlign.center,));
        dnaTextWidgets.add(highlightedContainer(dnaSequence.substring(indexes[i][0], indexes[i][1]).toUpperCase()));
      }

    }
    return dnaTextWidgets;
  }
}