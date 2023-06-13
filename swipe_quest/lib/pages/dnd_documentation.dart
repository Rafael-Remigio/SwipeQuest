/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_quest/pages/qrcode_cam.dart';
import 'package:swipe_quest/pages/sheets_page.dart';

import '../components/app_colors.dart';
import 'main_page.dart';

import 'signature_screen.dart';

class Documentation extends StatefulWidget {
  const Documentation({super.key});

  @override
  State<Documentation> createState() => _DocumentationState();
}

class _DocumentationState extends State<Documentation> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

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

  final _bottomNavigationBar = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/menu - home_active.svg',
            semanticsLabel: 'docs'),
        label: ""),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/menu - wallet.svg',
            semanticsLabel: 'home'),
        label: "D&D Docs"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/menu - analysis.svg',
            semanticsLabel: 'sheet'),
        label: "D&D Docs"),
    BottomNavigationBarItem(
        icon:
            SvgPicture.asset('assets/svg/menu - qr.svg', semanticsLabel: 'qr'),
        label: "D&D Docs")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 8, 30, 1),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 128),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 130.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Made by",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ))
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
                              child: SignatureScreen()),
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
}
*/