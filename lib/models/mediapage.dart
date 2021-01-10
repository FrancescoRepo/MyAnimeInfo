import 'package:flutter/material.dart';
import 'package:myanime_info/models/media.dart';
import 'package:myanime_info/models/pageinfo.dart';

class MediaPage {
  PageInfo pageInfo;
  List<Media> media;

  MediaPage({
    @required this.pageInfo,
    @required this.media,
  });

  MediaPage.fromJson(Map<String, dynamic> json) {
    this.pageInfo = new PageInfo.fromJson(json["Page"]["pageInfo"]);

    List<Media> mediaList = new List<Media>();
    for (dynamic mapItem in json["Page"]["media"]) {
      mediaList.add(new Media.fromJson(mapItem));
    }

    this.media = mediaList;
  }
}
