part of 'media_bloc.dart';

abstract class MediaState extends Equatable {
  const MediaState();
}

class FetchingMediaState extends MediaState {
  FetchingMediaState();

  @override
  List<Object> get props => [];
}

class FetchingMoreMediaState extends MediaState {
  @override
  List<Object> get props => [];
}

class FetchedMediaState extends MediaState {
  FetchedMediaState({this.searchTitle, @required this.mediaPage});

  final MediaPage mediaPage;
  final String searchTitle;

  @override
  List<Object> get props => [mediaPage];
}

class MediaErrorState extends MediaState {
  @override
  List<Object> get props => [];
}

class MediaUninitializedState extends MediaState {
  @override
  List<Object> get props => [];
}
