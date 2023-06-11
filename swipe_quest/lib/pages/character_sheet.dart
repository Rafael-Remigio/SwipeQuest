import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipe_quest/model/character.dart';
import 'package:swipe_quest/model/die.dart';
import 'package:swipe_quest/model/rols.dart';

import '../components/app_colors.dart';
import '../provider/sheetBox.dart';
import 'dnd_documentation.dart';
import 'game_page.dart';
import 'qrcode_cam.dart';
import 'sheets_page.dart';

import 'package:provider/provider.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({required this.characterKey, super.key});
  final String characterKey;
  @override
  _CharacterPageState createState() =>
      _CharacterPageState(characterKey: characterKey);
}

class _CharacterPageState extends State<CharacterPage> {
  _CharacterPageState({required this.characterKey});

  final String characterKey;

  final _bottomNavigationBar = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/menu - home.svg',
            semanticsLabel: 'docs'),
        label: ""),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/menu - wallet.svg',
            semanticsLabel: 'home'),
        label: ""),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/menu - analysis_active.svg',
            semanticsLabel: 'sheet'),
        label: ""),
    BottomNavigationBarItem(
        icon:
            SvgPicture.asset('assets/svg/menu - qr.svg', semanticsLabel: 'qr'),
        label: "")
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController systemController = TextEditingController();

  _onItemTapped(int index) {
    setState(() {
      var page;

      switch (index) {
        case 0:
          page = const Documentation();
          break;
        case 1:
          page = GamePage();
          break;
        case 2:
          page = SheetPage();
          break;
        case 3:
          page = const CameraQrCode();
          break;
        default:
          page = const Documentation();
          break;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    });
  }

  List<Widget> _buildRowList(List rolsList) {
    List<Widget> columnList = [];
    int index = 0;
    for (Rols i in rolsList) {
      Color current = AppColors.listColors[index];
      columnList.add(Container(
        decoration: BoxDecoration(
            color: current,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    i.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("${i.dice} + ${i.advantage}",
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ],
        ),
      ));
      columnList.add(const SizedBox(height: 10));
      index = (index + 1) % AppColors.listColors.length;
    }
    return columnList;
  }

  @override
  Widget build(BuildContext context) {
    final sheetBox = Provider.of<SheetBox>(context);
    Character character = sheetBox.get(characterKey);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 8, 30, 1),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('assets/svg/Sheet.png')),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                character.system,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ),
                    const Image(image: AssetImage('assets/svg/Vector.png')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Rols",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () => {
                        _showSimpleModalDialog(context)
                        /*setState(() {

                          sheetBox.addDice(
                              character, Rols("Great Sword", 2, {Die.d6: 2}));
                        })*/
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: MediaQuery.of(context).size.height * 0.35,
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: _buildRowList(character.rools),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Rols",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () => {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: _bottomNavigationBar,
        onTap: _onItemTapped,
      ),
    );
  }

  _showSimpleModalDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Die? groupValue = Die.d4;
          final sheetBox = Provider.of<SheetBox>(context);

          return StatefulBuilder(builder: (stfContext, setsfState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 400,
                    maxWidth: MediaQuery.of(context).size.width * 0.80),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          "Name"),
                      TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Abilty Name'),
                          controller: nameController),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              "Dice"),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D2'),
                                  value: Die.d2,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D4'),
                                  value: Die.d4,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D6'),
                                  value: Die.d6,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D8'),
                                  value: Die.d8,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D10'),
                                  value: Die.d10,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D12'),
                                  value: Die.d12,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<Die>(
                                  title: const Text('D20'),
                                  value: Die.d20,
                                  groupValue: groupValue,
                                  onChanged: (Die? value) {
                                    setsfState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Number of Die: "),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            ),
                          ),
                          Text("Advantage: "),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(), hintText: ''),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                sheetBox.addDice(sheetBox.get(characterKey),
                                    Rols("Great Sword", 2, {Die.d6: 2}));
                                setState(() {});
                              },
                              child: Text("Add Die")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
