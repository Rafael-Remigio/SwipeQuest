import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe_quest/model/character.dart';
import 'package:swipe_quest/pages/game_page.dart';
import 'package:provider/provider.dart';
import 'package:swipe_quest/provider/sheetBox.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  var box = await Hive.openBox<Character>('characterBox');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SheetBox(box: box))
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GamePage(),
    ),
  ));
}
