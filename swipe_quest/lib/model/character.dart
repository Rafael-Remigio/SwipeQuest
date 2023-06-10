import 'package:hive/hive.dart';

import 'rols.dart';

part 'character.g.dart';

@HiveType(typeId: 0)
class Character {
  Character({required this.name, required this.system, required this.rools});
  @HiveField(0)
  String name;

  @HiveField(1)
  String system;

  @HiveField(3)
  List<Rols> rools;
}
