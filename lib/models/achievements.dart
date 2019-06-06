import 'package:baobab_app/models.dart';
import 'package:flutter/material.dart';

class Achievements extends CelestialBody {
  final List<Song> songs;

  Achievements(
      {String name,
      this.songs = const [],
      String description,
      String intro,
      String formation,
      String history,
      String imgAssetPath,
      String vidAssetPath})
      : super(
          name: name,
          diameter: 0.28,
          color: Colors.grey,
          description: description,
          intro: intro,
          formation: formation,
          history: history,
          imgAssetPath: imgAssetPath,
          vidAssetPath: vidAssetPath,
        );
}
