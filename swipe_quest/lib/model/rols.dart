import 'package:hive_flutter/hive_flutter.dart';

import 'package:json_annotation/json_annotation.dart';

import 'die.dart';

part 'rols.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Rols {
  @HiveField(0)
  String name;
  @HiveField(1)
  int advantage;
  @HiveField(2)
  Die dice;
  @HiveField(3)
  int times;
  Rols(this.name, this.advantage, this.dice, this.times);

  factory Rols.fromJson(Map<String, dynamic> json) => _$RolsFromJson(json);

  Map<String, dynamic> toJson() => _$RolsToJson(this);
}
