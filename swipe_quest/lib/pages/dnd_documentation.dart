import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_quest/pages/game_page.dart';
import 'package:swipe_quest/pages/generate_qr_code.dart';
import 'package:swipe_quest/pages/sheets_page.dart';

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
          page = GamePage();
          break;
        case 2:
          page = SheetPage();
          break;
        case 3:
          page = const QRImage("Here");
          break;
        default:
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
        icon: SvgPicture.asset('assets/svg/helmet-svgrepo-com.svg',
            semanticsLabel: 'Label'),
        label: "classes"),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/helmet-svgrepo-com.svg',
            semanticsLabel: 'Label'),
        label: "races")
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
              children: const [ClassesPage(), RacesPage()]),
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          actions: [
            IconButton(
                color: Colors.black,
                icon: const Icon(Icons.notifications),
                tooltip: 'View Notifications',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('This is does nothing for now')));
                })
          ],
        ),
        body: FutureBuilder(
          future: fetchRaces(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  body: Center(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: snapshot.data!
                                .map((race) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text(race["name"])],
                                    ))
                                .toList(),
                          ))));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          actions: [
            IconButton(
                color: Colors.black,
                icon: const Icon(Icons.notifications),
                tooltip: 'View Notifications',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('This is does nothing for now')));
                })
          ],
        ),
        body: FutureBuilder(
          future: fetchClasses(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  body: Center(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: snapshot.data!
                                .map((race) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text(race["name"])],
                                    ))
                                .toList(),
                          ))));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}
