part of 'media_bloc.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();
}

class FetchMediaEvent extends MediaEvent {
  FetchMediaEvent({this.category, this.mediaType, this.page});
  final String category;
  final String mediaType;
  final String page;

  @override
  List<Object> get props => [category, mediaType, page];
}

class FetchMoreMediaEvent extends MediaEvent {
  FetchMoreMediaEvent({this.category, this.type, this.page});
  final String category;
  final String type;
  final String page;

  @override
  List<Object> get props => [category, type, page];
}

class SearchMediaEvent extends MediaEvent {
  SearchMediaEvent({this.title, this.type, this.page});
  final String title;
  final String type;
  final String page;

  @override
  List<Object> get props => [title, type, page];
}

class SwitchTypeMediaEvent extends MediaEvent {
  @override
  List<Object> get props => [];
}
