import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipe_quest/pages/game_page.dart';
import 'package:swipe_quest/pages/qrcode_cam.dart';
import 'package:swipe_quest/components/app_colors.dart';
import 'dnd_documentation.dart';

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
    for (Map<String, String> i in sheetList) {
      columnList.add(Container(
        color: Colors.green,
        child: Column(
          children: [
            Text(i["name"]!),
            Text(i["system"]!),
          ],
        ),
      ));
      columnList.add(SizedBox(height: 10));
    }

    return columnList;
  }

  final elements = <Map<String, String>>[
    new Map.from({"name": "josé", "system": "dnd"}),
    new Map.from({"name": "ohh Rui", "system": "tormenta"}),
  ];

  @override
  Widget build(BuildContext context) {
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
                    Image(image: AssetImage('assets/svg/Group.png')),
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
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () => {},
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
                            height: MediaQuery.of(context).size.height * 0.50,
                            color: const Color(0xFF1E1E1E),
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: _buildRowList(elements),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )
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
