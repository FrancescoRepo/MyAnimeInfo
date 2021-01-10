import 'package:flutter/material.dart';
import 'package:myanime_info/models/character.dart';
import 'package:myanime_info/models/episode.dart';
import 'package:myanime_info/models/staff.dart';

class Media {
  String title;
  String coverImage;
  String type;
  String status;
  String description;
  String startDate;
  String endDate;
  String season;
  int volumes;
  int chapters;
  int nEpisodes;
  int duration;
  int averageScore;
  int popularity;
  bool isAdult;
  List<Character> characters = new List();
  List<Staff> staff = new List();
  List<Episode> episodes = new List<Episode>();

  Media({
    @required this.title,
    @required this.coverImage,
    @required this.type,
    @required this.status,
    @required this.description,
    @required this.startDate,
    @required this.endDate,
    @required this.season,
    @required this.volumes,
    @required this.chapters,
    @required this.averageScore,
    @required this.popularity,
    @required this.isAdult,
    @required this.nEpisodes,
    @required this.duration,
    @required this.characters,
  });

  Media.fromJson(Map<String, dynamic> json) {
    this.title = json["title"]["romaji"];
    this.coverImage = json["coverImage"]["medium"];
    this.type = json["type"];
    this.status = json["status"];
    this.description = json["description"];
    this.startDate = json["startDate"]["day"].toString() +
        "/" +
        json["startDate"]["month"].toString() +
        "/" +
        json["startDate"]["year"].toString();
    this.endDate = json["endDate"]["day"].toString() +
        "/" +
        json["endDate"]["month"].toString() +
        "/" +
        json["endDate"]["year"].toString();
    this.nEpisodes = json["episodes"];
    this.duration = json["duration"];
    this.season = json["season"];
    this.volumes = json["volumes"];
    this.chapters = json["chapters"];
    this.averageScore = json["averageScore"];
    this.popularity = json["popularity"];
    this.isAdult = json["isAdult"];
    for (dynamic character in json["characters"]["nodes"])
      this.characters.add(new Character.fromJson(character));
    for (dynamic staff in json["staff"]["nodes"])
      this.staff.add(new Staff.fromJson(staff));
    for (dynamic episode in json["streamingEpisodes"])
      this.episodes.add(new Episode.fromJson(episode));
  }
}
