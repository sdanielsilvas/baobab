import 'package:flutter/material.dart';
import 'package:baobab_app/models.dart';

class CelestialBody {
  final String name;
   double diameter;
  final Color color;
  final String description;
  final String intro;
  final String formation;
  final String history;
  final String imgAssetPath;
  final String vidAssetPath;
  final List<Song> songs;

  CelestialBody({
    @required this.name,
    @required this.diameter,
    @required this.color,
    this.songs,
    this.description,
    this.intro,
    this.formation,
    this.history,
    this.imgAssetPath,
    this.vidAssetPath,
  });
}
