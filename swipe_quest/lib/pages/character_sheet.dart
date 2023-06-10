import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  List<Widget> _buildRowList(List sheetList) {
    List<Widget> columnList = [];
    int index = 0;
    for (Map<String, String> i in sheetList) {
      Color current = AppColors.listColors[index];

      columnList.add(Container());
      columnList.add(const SizedBox(height: 10));
      index = (index + 1) % AppColors.listColors.length;
    }
    return columnList;
  }

  @override
  Widget build(BuildContext context) {
    final sheetBox = Provider.of<SheetBox>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 8, 30, 1),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    const Image(image: AssetImage('assets/svg/Group.png')),
                    Text(
                      sheetBox.get(characterKey).name +
                          sheetBox.get(characterKey).system,
                      style: TextStyle(
                          color: AppColors.lighBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
                )
              ],
            ),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: _bottomNavigationBar,
        onTap: _onItemTapped,
      ),
    );
  }
}
