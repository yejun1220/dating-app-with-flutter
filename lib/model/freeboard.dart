import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'freeboard.g.dart';

@JsonSerializable()
class FreeBoard {
  final String id;
  final String title;
  final String content;
  final String userName;
  final List<String> isPressedList;
  final Timestamp time;
  final int comments;

  FreeBoard(this.id, this.title, this.content, this.userName, this.isPressedList, this.time, this.comments);

  factory FreeBoard.fromJson(Map<String, dynamic> json) => _$FreeBoardFromJson(json);

  Map<String, dynamic> toJson() => _$FreeBoardToJson(this);
}
