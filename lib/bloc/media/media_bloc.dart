import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myanime_info/models/media.dart';
import 'package:myanime_info/models/mediapage.dart';
import 'package:myanime_info/repositories/media_repository.dart';

part 'media_event.dart';

part 'media_state.dart';

enum SearchType { CATEGORY_SEARCH, MEDIA_SEARCH }
enum MediaType { Anime, Manga }

extension TypeEx on MediaType {
  String get inString => describeEnum(this);
}

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc({@required this.mediaRepository})
      : super(MediaUninitializedState());

  final MediaRepository mediaRepository;

  List<Media> _mediaList = [];

  @override
  Stream<MediaState> mapEventToState(
    MediaEvent event,
  ) async* {
    try {
      if (event is FetchMediaEvent) {
        yield FetchingMediaState();

        _mediaList.clear();

        MediaPage mediaPage = await mediaRepository.getMediaPage(
            event.category, event.mediaType, event.page);

        _mediaList.addAll(mediaPage.media);

        yield FetchedMediaState(mediaPage: mediaPage);
      } else if (event is FetchMoreMediaEvent) {
        MediaPage mediaPage = await mediaRepository.getMediaPage(
            event.category, event.type, event.page);

        _mediaList.addAll(mediaPage.media);

        mediaPage.media.clear();
        mediaPage.media.addAll(_mediaList);

        yield FetchedMediaState(mediaPage: mediaPage);
      } else if (event is SearchMediaEvent) {
        yield FetchingMediaState();
        _mediaList.clear();

        MediaPage mediaPage = await mediaRepository.searchMedia(
            event.title, event.type, event.page);

        _mediaList.addAll(mediaPage.media);

        yield FetchedMediaState(mediaPage: mediaPage, searchTitle: event.title);
      } else if (event is SwitchTypeMediaEvent) {
        _mediaList.clear();
        MediaPage mediaPage = MediaPage(media: []);
        yield FetchedMediaState(mediaPage: mediaPage);
      }
    } catch (error) {
      yield MediaErrorState();
    }
  }

  void fetchMedia(String category, String type, String page) =>
      add(FetchMediaEvent(category: category, mediaType: type, page: page));

  void fetchMoreMedia(String category, String type, String page) =>
      add(FetchMoreMediaEvent(category: category, type: type, page: page));

  void searchMedia(String title, String type, String page) {
    if (title != null && title.isNotEmpty)
      add(SearchMediaEvent(title: title, type: type, page: page));
  }

  void switchTypeMedia() => add(SwitchTypeMediaEvent());
}
