import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'site')
  final String site;

  Episode({
    @required this.title,
    @required this.thumbnail,
    @required this.url,
    @required this.site,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}
