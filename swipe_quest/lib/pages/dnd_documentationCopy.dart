import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_quest/components/app_colors.dart';
import 'package:swipe_quest/pages/classe_page.dart';
import 'package:swipe_quest/pages/qrcode_cam.dart';
import 'package:swipe_quest/pages/racePage.dart';
import 'package:swipe_quest/pages/sheets_page.dart';
import 'package:swipe_quest/pages/signature_screen.dart';

import 'main_page.dart';

Future<List<dynamic>> fetchRaces() async {
  String url = "https://www.dnd5eapi.co/api/races";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // need to use utf8 decode because of special chars
    Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

    //debugPrint(posts.toString());
    return body["results"];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<dynamic>> fetchClasses() async {
  String url = "https://www.dnd5eapi.co/api/classes";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // need to use utf8 decode because of special chars
    Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

    //debugPrint(posts.toString());
    return body["results"];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

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

  final _dndBottomNavigationBar = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/devs.svg', semanticsLabel: 'Label'),
        label: "Devs"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/helmet-svgrepo-com.svg',
            semanticsLabel: 'Label'),
        label: "Classes"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/orc-head.svg',
            height: 40, semanticsLabel: 'Label'),
        label: "Races")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
          body: PageView(
              controller: _pageController,
              onPageChanged: (newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: MediaQuery.of(context).size.height * 0.50,
                    padding: const EdgeInsets.all(10.0),
                    child: SignatureScreen()),
                ClassesPage(),
                RacesPage()
              ]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: _dndBottomNavigationBar,
            onTap: (tappedIndex) {
              setState(() {
                _pageController.animateToPage(tappedIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              });
            },
            //type: BottomNavigationBarType.fixed,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: _bottomNavigationBar,
          onTap: _onItemTapped,
        ));
  }
}

class RacesPage extends StatelessWidget {
  const RacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rng = Random();

    return Scaffold(
      body: FutureBuilder(
        future: fetchRaces(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: Color(0xFF1E1E1E),
                body: Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: snapshot.data!
                              .map((race) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DnDRaceDetailsPage(
                                                          className:
                                                              race["index"],
                                                        )));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.listColors[
                                                    rng.nextInt(AppColors
                                                        .listColors.length)],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15))),
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.70,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          race["name"],
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ))));
          } else {
            return Scaffold(
                backgroundColor: Color(0xFF1E1E1E),
                body: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    return Scaffold(
      body: FutureBuilder(
        future: fetchClasses(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                backgroundColor: Color(0xFF1E1E1E),
                body: Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: snapshot.data!
                              .map((race) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DnDClassDetailsPage(
                                                          className:
                                                              race["index"],
                                                        )));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.listColors[
                                                    rng.nextInt(AppColors
                                                        .listColors.length)],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15))),
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.70,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          race["name"],
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ))));
          } else {
            return Scaffold(
                backgroundColor: Color(0xFF1E1E1E),
                body: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
