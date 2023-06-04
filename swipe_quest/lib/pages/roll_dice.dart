import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:swipe_quest/pages/generate_qr_code.dart';
import 'dart:math';

import 'package:swipe_quest/pages/qrcode_cam.dart';

import 'dnd_documentation.dart';

void main() => runApp(RollDice());

class RollDice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RPGDiceRollerPage(),
    );
  }
}

class RPGDiceRollerPage extends StatefulWidget {
  @override
  _RPGDiceRollerPageState createState() => _RPGDiceRollerPageState();
}

class _RPGDiceRollerPageState extends State<RPGDiceRollerPage> {
  int diceValue = 1;
  int soundEffect = 0;
  bool isRolling = false;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  List<int> diceTypes = [4, 6, 8, 10, 12, 20];
  int selectedDiceType = 6;

  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_assignValues);
    startAccelerometer();
  }

  void _assignValues() {
    print('Second text field: ${myController.text}');
  }

  @override
  void dispose() {
    stopAccelerometer();
    myController.dispose();
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
      diceValue = Random().nextInt(selectedDiceType) + 1;
      isRolling = false;
    });
  }

  void changeDiceType(int value) {
    setState(() {
      selectedDiceType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RPG Dice Roller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: selectedDiceType,
              onChanged: (value) => changeDiceType(value!),
              items: diceTypes.map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('D$value'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            isRolling
                ? CircularProgressIndicator()
                : Text(
                    'Dice Value: $diceValue',
                    style: TextStyle(fontSize: 24),
                  ),
            ElevatedButton(
              child: Text("Go to camera"),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CameraQrCode(),
                  ),
                )
              },
            ),
            TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
                controller: myController),
            ElevatedButton(
              child: Text("Generate QR from text"),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRImage(myController.text),
                  ),
                )
              },
            ),
            ElevatedButton(
              child: Text("Documentation"),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Documentation(),
                  ),
                )
              },
            )
          ],
        ),
      ),
    );
  }
}
