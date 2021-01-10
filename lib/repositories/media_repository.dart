import 'package:flutter/material.dart';
import 'package:myanime_info/models/mediapage.dart';
import 'package:myanime_info/network/rest_client.dart';

class MediaRepository {
  MediaRepository({@required this.restClient});

  final RestClient restClient;

  Future<MediaPage> getMediaPage(String category, String type, String page) => restClient.getMediaOfCategory(category, type, page);

  Future<MediaPage> searchMedia(String title, String type, String page) => restClient.searchMedia(title, type, page);
}