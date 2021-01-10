import 'package:flutter/material.dart';
import 'package:myanime_info/bloc/media/media_bloc.dart';
import 'package:myanime_info/models/media.dart';

class MediaDetailScreenArgument {
  final Media media;
  final MediaType type;

  MediaDetailScreenArgument({
    @required this.media,
    @required this.type,
  });
}
