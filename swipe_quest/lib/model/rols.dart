import 'package:hive_flutter/hive_flutter.dart';

import 'die.dart';

part 'rols.g.dart';

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
}
