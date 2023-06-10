import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe_quest/model/character.dart';

import '../model/rols.dart';

class SheetBox extends ChangeNotifier {
  SheetBox({required this.box});
  final Box box;

  put(Character character) {
    box.put("key_${character.name}", character);
  }

  delete(Character character) {
    box.delete("key_${character.name}");
  }

  Character get(String key) {
    return box.get(key);
  }

  addDice(Character currentCharacter, Rols rol) {
    Character char = box.get("key_${currentCharacter.name}");

    char.rools.add(rol);

    put(char);
  }

  updateNameAndSystem(Character currentCharacter, String name, String system) {
    Character char = box.get("key_${currentCharacter.name}");

    char.name = name;
    char.system = system;

    if (box.containsKey("key_${currentCharacter.name}")) {
      char.name = "${char.name}_1";
    }
    delete(currentCharacter);
    put(char);
  }
}
