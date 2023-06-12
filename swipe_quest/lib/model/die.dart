import 'package:hive/hive.dart';

import 'package:json_annotation/json_annotation.dart';

part 'die.g.dart';

@HiveType(typeId: 10)
enum Die {
  @JsonValue(0)
  @HiveField(0)
  d2,
  @JsonValue(1)
  @HiveField(1)
  d4,
  @JsonValue(2)
  @HiveField(2)
  d6,
  @JsonValue(3)
  @HiveField(3)
  d8,
  @JsonValue(4)
  @HiveField(4)
  d10,
  @JsonValue(5)
  @HiveField(5)
  d12,
  @JsonValue(6)
  @HiveField(6)
  d20
}
