import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:swipe_quest/model/character.dart';
import 'package:swipe_quest/pages/game_page.dart';
import 'package:provider/provider.dart';
import 'package:swipe_quest/pages/main_page.dart';
import 'package:swipe_quest/pages/map_page.dart';
import 'package:swipe_quest/provider/sheetBox.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



import 'model/die.dart';
import 'model/rolHistory.dart';
import 'model/rols.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RolHistoryAdapter());
  Hive.registerAdapter(DieAdapter());
  Hive.registerAdapter(RolsAdapter());
  Hive.registerAdapter(CharacterAdapter());
  var box = await Hive.openBox<Character>('characterBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SheetBox(box: box))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
  )
  );
}
