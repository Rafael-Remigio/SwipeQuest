import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe_quest/model/character.dart';
import 'package:swipe_quest/model/rolHistory.dart';

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
    var here = box.get(key);
    if (here != null) {
      return here;
    } else {
      return Character(
          name: "", system: "", rolsHistory: List.empty(), rools: List.empty());
    }
  }

  List<Character> getAll() {
    return box.toMap().values.toList() as List<Character>;
  }

  addDice(Character currentCharacter, Rols rol) {
    Character char = box.get("key_${currentCharacter.name}");

    List<Rols> rols = char.rools;
    rols.add(rol);
    char.rools = rols;

    box.put("key_${currentCharacter.name}", char);
  }

  deleteDice(String currentCharacter, Rols rol) {
    Character char = box.get(currentCharacter);

    List<Rols> rols = char.rools;
    rols.remove(rol);
    char.rools = rols;

    box.put(currentCharacter, char);
  }

  addHistoryEntry(Character currentCharacter, RolHistory rol) {
    Character char = box.get("key_${currentCharacter.name}");

    List<RolHistory> rols = char.rolsHistory;
    rols.add(rol);
    char.rolsHistory = rols;

    box.put("key_${currentCharacter.name}", char);
  }

  deleteHistory(String currentCharacter) {
    Character char = box.get(currentCharacter);

    char.rolsHistory = List.empty(growable: true);

    box.put(currentCharacter, char);
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
