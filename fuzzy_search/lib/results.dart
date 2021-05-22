import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'style.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  FilePickerResult dnaSequence;
  TextStyle _textStyle = TextStyle(
    fontSize: 30,
    color: Colors.white,
  );
  TextStyle _highlightedTextStyle = TextStyle(fontSize: 30, color: Colors.grey);
  String _dnaText;
  Map<String, HighlightedWord> words;

  @override
  void initState() {
    super.initState();
    _dnaText =
        "GCAGTTTAAGTCGGGACAATAGGAGCCGCAATACACAGTTTACCGCATCTTGACCTAACTGACATACTGCCATGGACGACTAGCCATGCCACTGGCTCTTAGATAGCCCGATACAGTGATTATGAAAGGTTTGCGGGGCATAGCTACGACTTGCTTAGCTACGTGCGAGGGAAGAAACTTTTGCGTATTTGTATGTTCACCCGTCTACTACCCATGCCCGGAGATTATGTAGGTTGTGAGATGCGGGAGAAGTTCTCGACCTTCCCGTGGGACGTCAACCTATCCCTTAATAGAGCATTCCGTTCGGGCATGGCAGTAAGTACGCCTTCTCAATTGTGCTAACCTTCATCCTTATCAAAGCTTGGAGCCAATGATCAGGATTATTGCCTTGCGACAGACTTCCTACTCACAGTCGCTCACATTGAGCTACTCGATGGGTCATCAGCTTGACCCGGTCTGTTGGGCCGCGATTACGTGAGTTAGGGCTCCGGACTGCGCTGTATAGTCGAATCTGATCCGGCCCCCACAACTGCAAACCCCAACTTATTTAGATAACATGATTAGCCGAAGTTGCACGGGGTGCCCACCGTGGAGTCCTCCCCGGGTGTCCCTCCTTCATTTGACGATAAGCAGCCGCTACCACCATCGATTAATACAAGGAACGGTGATGTTATCATAGATTCGGCACATTACCCTTGTAGGTGTGGAATCACTTAGCTACGCGCCGAAGTCTTATGGCAAAACCGATGGACAATGATTCGGGTAGCACTAAAAGTCCATAGCACGTGCATCCCAACGTGGCGTGCGTACAGCTTAACCACCGCTTCATGCTAAGGTGCTGGCTGCATGCTAAGTTGATACGCCTGCACTGCTCGAAGAAAATATACGAAGCGGGCGGCCTGGCCGGAGCACTACCCCATCGACGCGTACTCGAATACTGTTAATTGCTCACACATGAACAAAATAGTAGAGTGTCACTTTCAGCCCTCTTATCCTCGGC";
    words = {
      "AA": HighlightedWord(
        onTap: () {
          print("AAGTCG");
        },
        textStyle: _highlightedTextStyle,
      ),
    };
  }

  Widget _getDnaText(List<List<int>> indexes) {
    List<TextSpan> spans = [];
    bool highlighted;
    if (indexes[0][0] == 0) {
      highlighted = true;
    } else {
      highlighted = false;
    }
    int currentIndex = 0;
    for (List<int> index in indexes) {
      if (!highlighted) {
        spans.add(TextSpan(
          text: _dnaText.substring(currentIndex, index[0]),
        ));
        currentIndex=index[0];
        highlighted=true;
      } else {
        spans.add(TextSpan(
          style: _highlightedTextStyle,
          text: _dnaText.substring(currentIndex, index[1]),
        ));
        currentIndex=index[1];
        highlighted=false;
      }
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(style: _textStyle, children: spans)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String _githubUrl = "https://github.com/FaazAbidi/Fuzzy-DNA-Search/blob/main/fuzzy_search/README.md";

    return Container(
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
                      flex: 3,
                      child: Column(
                        children: [
                          _getDnaText([[9,11],[13,21],[24,28]])
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(color: Colors.blue),
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
    );
  }
}
