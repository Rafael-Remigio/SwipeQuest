import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import 'package:swipe_quest/model/rols.dart';

import '../model/die.dart';

class RPGDiceRollerPage extends StatefulWidget {
  RPGDiceRollerPage(this.rol);
  Rols rol;
  @override
  _RPGDiceRollerPageState createState() => _RPGDiceRollerPageState(rol);
}

class _RPGDiceRollerPageState extends State<RPGDiceRollerPage> {
  _RPGDiceRollerPageState(this.rol);
  Rols rol;
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
    setState(() {
      for (int i = 0; i < rol.times; i++) {
        diceValue += Random().nextInt(diceTypes[rol.dice]!) + 1;
      }
      diceValue += rol.advantage;
      isRolling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          isRolling
              ? CircularProgressIndicator()
              : Text(
                  'Dice Value: $diceValue',
                  style: TextStyle(fontSize: 24),
                ),
        ],
      ),
    );
  }
}
