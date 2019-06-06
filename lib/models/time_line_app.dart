import 'package:baobab_app/database/database.dart';
import 'package:baobab_app/utils/color_utility.dart';
import 'package:flutter/material.dart';

import 'celestial_body.dart';

class TimeLineApp extends CelestialBody {
  String id;
  String name;
  String description;
  String imgAssetPath = 'assets/fase1.png';
  Color color ;

  String vidAssetPath = 'assets/mercury.webp';
  List<Achievement> achievements;

  TimeLineApp({this.name, this.description, this.achievements});

  TimeLineApp.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json["id"];
    name = json['name'];
    description = json["description"];
    diameter = 2.483;

    color = Color(int.parse(json["color"]));
    achievements = [];
  }

  Future<TimeLineApp> createModel(Map<String, dynamic> parsedJson) async {
    var result = await Database.readDocumentsSubCollection(parsedJson["id"], "timeline", "achievements", 100);
    achievements = result.map((item) => Achievement.fromJson(item)).toList();
    print(achievements);
    return TimeLineApp(name: parsedJson['name'], description: parsedJson["description"], achievements: achievements);
  }

  Future<List<TimeLineApp>> createModelList(List<Map<String, dynamic>> documents) async {
    var result = documents.map((item) => createModel(item)).toList();
    var output = result.map((item) => item.then((data) => data)).toList();

    return Future.value(null);
    //  var data = result.map((item) => item.then((onValue) => onValue)).toList();

    //return Future.value(data);
  }
}

class Achievement extends CelestialBody {
  String id;
  String name;
  String description;
  String vidAssetPath;
  String img;
  Color color = Colors.red;

  Achievement.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    img = json["img"];
    description = json["description"];
    diameter = 0.483;
    id = json["id"];



  }
}
