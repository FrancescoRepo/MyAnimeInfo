import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pageinfo.g.dart';

@JsonSerializable(createToJson: false)
class PageInfo {
  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'perPage')
  final int perPage;

  @JsonKey(name: 'hasNextPage')
  final bool hasNextPage;

  @JsonKey(name: 'currentPage')
  final int currentPage;

  @JsonKey(name: 'lastPage')
  final int lastPage;

  PageInfo({
    @required this.total,
    @required this.perPage,
    @required this.hasNextPage,
    @required this.currentPage,
    @required this.lastPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);
}
