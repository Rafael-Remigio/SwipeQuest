import 'package:hive/hive.dart';

part 'die.g.dart';

@HiveType(typeId: 10)
enum Die {
  @HiveField(0)
  d2,
  @HiveField(1)
  d4,
  @HiveField(2)
  d6,
  @HiveField(3)
  d8,
  @HiveField(4)
  d10,
  @HiveField(5)
  d12,
  @HiveField(6)
  d20
}
