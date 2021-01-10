// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    title: json['title'] as String,
    thumbnail: json['thumbnail'] as String,
    url: json['url'] as String,
    site: json['site'] as String,
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'url': instance.url,
      'site': instance.site,
    };
