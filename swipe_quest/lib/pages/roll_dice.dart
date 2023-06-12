import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:swipe_quest/model/rolHistory.dart';
import 'dart:math';

import 'package:swipe_quest/model/rols.dart';

import '../model/die.dart';
import '../provider/sheetBox.dart';
import 'package:provider/provider.dart';

class RPGDiceRollerPage extends StatefulWidget {
  RPGDiceRollerPage(this.rol, this.characterKey);
  Rols rol;
  String characterKey;
  @override
  _RPGDiceRollerPageState createState() =>
      _RPGDiceRollerPageState(rol, characterKey);
}

class _RPGDiceRollerPageState extends State<RPGDiceRollerPage> {
  _RPGDiceRollerPageState(this.rol, this.characterKey);
  Rols rol;
  String characterKey;

  int diceValue = -1;
  int soundEffect = 0;
  bool isRolling = false;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  Map<Die, int> diceTypes = {
    Die.d2: 2,
    Die.d4: 4,
    Die.d6: 6,
    Die.d8: 8,
    Die.d10: 10,
    Die.d12: 12,
    Die.d20: 20
  };

  @override
  void initState() {
    super.initState();
    startAccelerometer();
  }

  @override
  void dispose() {
    stopAccelerometer();
    super.dispose();
  }

  void startAccelerometer() {
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if (!isRolling &&
          (event.x.abs() > 40 || event.y.abs() > 40 || event.z.abs() > 40)) {
        setState(() {
          isRolling = true;
        });
        rollDice();
      }
    });
  }

  void stopAccelerometer() {
    _streamSubscription.cancel();
  }

  void playRandomSoundEffect() {
    final player = AudioCache();
    switch (Random().nextInt(3) + 1) {
      case 1:
        player.play('audio/diceSoundEffect1.mp3');
        break;
      case 2:
        player.play('audio/diceSoundEffect2.mp3');
        break;
      case 3:
        player.play('audio/diceSoundEffect3.mp3');
        break;
    }
  }

  Future<void> rollDice() async {
    playRandomSoundEffect();
    await Future.delayed(const Duration(seconds: 1));
    List<int> values = List.empty(growable: true);
    setState(() {
      for (int i = 0; i < rol.times; i++) {
        values.add(Random().nextInt(diceTypes[rol.dice]!) + 1);
        diceValue += values[i];
      }
      diceValue += rol.advantage;
      isRolling = false;
      stopAccelerometer();
    });
    final sheetBox = Provider.of<SheetBox>(context, listen: false);

    sheetBox.addHistoryEntry(sheetBox.get(characterKey),
        RolHistory(rol.name, rol.advantage, values, DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final sheetBox = Provider.of<SheetBox>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          isRolling
              ? const CircularProgressIndicator()
              : (diceValue == -1)
                  ? const Text(
                      'Shake to throw the Die',
                      style: TextStyle(fontSize: 24),
                    )
                  : Text(
                      'Dice Value: $diceValue',
                      style: const TextStyle(fontSize: 24),
                    ),
        ],
      ),
    );
  }
}
