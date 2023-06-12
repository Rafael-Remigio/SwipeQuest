import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipe_quest/model/character.dart';
import 'package:swipe_quest/model/die.dart';
import 'package:swipe_quest/model/rolHistory.dart';
import 'package:swipe_quest/model/rols.dart';
import 'package:swipe_quest/pages/generate_qr_code.dart';
import 'package:swipe_quest/pages/roll_dice.dart';

import '../components/app_colors.dart';
import '../provider/sheetBox.dart';
import 'dnd_documentation.dart';
import 'dnd_documentationCopy.dart';
import 'main_page.dart';
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
  TextEditingController numberController = TextEditingController();
  TextEditingController advantageController = TextEditingController();

  _onItemTapped(int index) {
    setState(() {
      var page;

      switch (index) {
        case 0:
          page = const Documentation();
          break;
        case 1:
          page = MainPage();
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
      columnList.add(GestureDetector(
        onLongPress: () {
          _showDeletegModal(context, i);
        },
        onTap: () {
          _showRollingModal(context, i);
        },
        child: Container(
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
        ),
      ));
      columnList.add(const SizedBox(height: 10));
      index = (index + 1) % AppColors.listColors.length;
    }
    return columnList;
  }

  List<Widget> _buildHistoryList(List rolsList) {
    List<Widget> columnList = [];
    int index = 0;
    for (RolHistory i in rolsList) {
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
                  Text("${i.advantage} + ${i.values}",
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal)),
                  Text("${i.dateTime}",
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
    Character character = Character(
        name: "name",
        system: "system",
        rools: List.empty(growable: true),
        rolsHistory: List.empty(growable: true));
    try {
      character = sheetBox.get(characterKey);
    } catch (e) {}
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
                    GestureDetector(
                        onTap: () {
                          _editNameModal(context);
                        },
                        child: const Image(
                            image: AssetImage('assets/svg/Vector.png'))),
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
                      onPressed: () => {_showSimpleModalDialog(context)},
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "History",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.white,
                      onPressed: () => {
                        setState(() {
                          sheetBox.deleteHistory(characterKey);
                        })
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
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children:
                                      _buildHistoryList(character.rolsHistory),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lighBlue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    onPressed: () {
                      _showQRCodeModal(context, character);
                    },
                    child: const Text("Share this character")),
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
                  child: SingleChildScrollView(
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
                            const Text("Number of Die: "),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(), hintText: ''),
                                controller: numberController,
                              ),
                            ),
                            const Text("Advantage: "),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(), hintText: ''),
                                controller: advantageController,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              sheetBox.addDice(
                                  sheetBox.get(characterKey),
                                  Rols(
                                      nameController.text,
                                      int.parse(advantageController.text),
                                      groupValue!,
                                      int.parse(numberController.text)));
                              nameController.text = "";
                              numberController.text = "";
                              setState(() {});
                            },
                            child: const Text("Add Die")),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  _showRollingModal(context, Rols rol) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
                    children: [RPGDiceRollerPage(rol, characterKey)],
                  ),
                ),
              ),
            );
          });
        }).then((value) => setState(() {}));
  }

  _editNameModal(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (stfContext, setsfState) {
            final sheetBox = Provider.of<SheetBox>(context);
            Character char = sheetBox.get(characterKey);
            nameController.text = char.name;
            systemController.text = char.system;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Name",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Character Name'),
                            controller: nameController),
                        const SizedBox(height: 20),
                        Text("RPG System",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'RPG System'),
                            controller: systemController),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();

                                sheetBox.delete(char);
                                sheetBox.put(Character(
                                    name: nameController.text,
                                    system: systemController.text,
                                    rools: char.rools,
                                    rolsHistory: char.rolsHistory));
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CharacterPage(
                                      characterKey:
                                          "key_${nameController.text}",
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.lighBlue),
                              child: const Text("Create"),
                            )
                          ],
                        )
                      ]),
                ),
              ),
            );
          });
        });
  }

  _showDeletegModal(context, Rols rol) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (stfContext, setsfState) {
            final sheetBox = Provider.of<SheetBox>(context);

            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 300,
                    maxWidth: MediaQuery.of(context).size.width * 0.80),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            sheetBox.deleteDice(characterKey, rol);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.red,
                          )),
                      const Text("Delete Ability")
                    ],
                  ),
                ),
              ),
            );
          });
        }).then((value) => setState(() {}));
  }

  _showQRCodeModal(context, Character character) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
                    children: [QRImage(character)],
                  ),
                ),
              ),
            );
          });
        }).then((value) => setState(() {}));
  }
}
