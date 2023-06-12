import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipe_quest/model/character.dart';
import 'package:swipe_quest/model/rols.dart';
import 'package:swipe_quest/pages/character_sheet.dart';
import 'package:swipe_quest/pages/game_page.dart';
import 'package:swipe_quest/pages/main_page.dart';
import 'package:swipe_quest/pages/qrcode_cam.dart';
import 'package:swipe_quest/components/app_colors.dart';
import 'package:swipe_quest/provider/sheetBox.dart';
import '../model/rolHistory.dart';
import 'dnd_documentation.dart';
import 'package:provider/provider.dart';

import 'dnd_documentationCopy.dart';

class SheetPage extends StatefulWidget {
  @override
  _SheetPageState createState() => _SheetPageState();
}

class _SheetPageState extends State<SheetPage> {
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

  List<Widget> _buildRowList(List sheetList) {
    List<Widget> columnList = [];
    int index = 0;
    for (Character i in sheetList) {
      Color current = AppColors.listColors[index];

      columnList.add(GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CharacterPage(characterKey: "key_${i.name}")),
          );
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
                    Text(i.system,
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

  @override
  Widget build(BuildContext context) {
    final sheetBox = Provider.of<SheetBox>(context);

    var elements = sheetBox.getAll();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 8, 30, 1),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      const Image(image: AssetImage('assets/svg/Group.png')),
                      Text(
                        "SwipeQuest",
                        style: TextStyle(
                            color: AppColors.lighBlue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Sheets",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () => {_onAddCharacter()},
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
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
                              height: MediaQuery.of(context).size.height * 0.50,
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: _buildRowList(elements),
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

  void _onAddCharacter() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          final sheetBox = Provider.of<SheetBox>(context);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Character Name'),
                      controller: nameController),
                  const SizedBox(height: 20),
                  Text("RPG System",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'RPG System'),
                      controller: systemController),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          sheetBox.put(Character(
                              name: nameController.text,
                              system: systemController.text,
                              rools: List<Rols>.empty(growable: true),
                              rolsHistory:
                                  List<RolHistory>.empty(growable: true)));
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CharacterPage(
                                characterKey: "key_${nameController.text}",
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lighBlue),
                        child: const Text("Create"),
                      )
                    ],
                  )
                ]),
          );
        });
  }
}
