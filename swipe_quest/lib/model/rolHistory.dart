import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rolHistory.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class RolHistory {
  @HiveField(0)
  String name;
  @HiveField(1)
  int advantage;
  @HiveField(2)
  List<int> values;
  @HiveField(3)
  DateTime dateTime;
  RolHistory(this.name, this.advantage, this.values, this.dateTime);

  factory RolHistory.fromJson(Map<String, dynamic> json) =>
      _$RolHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RolHistoryToJson(this);
}
