import 'package:flutter/material.dart';
import 'package:swipe_quest/pages/game_page.dart';
import 'package:swipe_quest/pages/roll_dice.dart';

void main() {
  //runApp(const MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GamePage(),
  ));
}
