import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


class DiagramData {
  int topicNumber;
  String imageExtension;
  String diagram;
  String labelA;
  String labelB;
  String labelC;
  String labelD;
  String labelE;
  String labelF;
  String labelG;
  String labelH;
  String labelI;

  DiagramData(
      {this.topicNumber,
        this.imageExtension,
        this.diagram,
        this.labelA,
        this.labelB,
        this.labelC,
        this.labelD,
        this.labelE,
        this.labelF,
        this.labelG,
        this.labelH,
        this.labelI});

  DiagramData.fromJson(Map<String, dynamic> json) {
    topicNumber = json['Topic Number'];
    imageExtension = json['Image Extension'];
    diagram = json['Diagram'];
    labelA = json['Label A'];
    labelB = json['Label B'];
    labelC = json['Label C'];
    labelD = json['Label D'];
    labelE = json['Label E'];
    labelF = json['Label F'];
    labelG = json['Label G'];
    labelH = json['Label H'];
    labelI = json['Label I'];
  }
}

Future<String> _loadQuestionAsset() async {
  return await rootBundle.loadString('assets/localData/Diagrams.json');
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

Future<List<DiagramData>> loadQuestions() async {
  await wait(2);
  String jsonString = await _loadQuestionAsset();
  Iterable jsonResponse = json.decode(jsonString);
  List<DiagramData> questions = List<DiagramData>.from(jsonResponse.map((model)=> DiagramData.fromJson(model)));
  return questions;
}

List<String> getDiagramStrings(int topic,List<DiagramData> diagramMap_1){
  List<String> diagrams = [];
  List<DiagramData> temp = diagramMap_1.where((l) => l.topicNumber == topic).toList();
  for(int i = 0; i < temp.length; i++){
    diagrams.add(temp[i].diagram);
  }
  return diagrams;
}

List<DiagramData> getDiagramsTopic(int topic,List<DiagramData> diagramMap_1){
  List<DiagramData> temp = diagramMap_1.where((l) => l.topicNumber == topic).toList();
  return temp;
}
