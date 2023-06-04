import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;

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
  final _bottomNavigationBar = [
    BottomNavigationBarItem(icon: Icon(Icons.star), label: "classes"),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "races")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          children: [ClassesPage(), RacesPage()]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavigationBar,
        onTap: (tappedIndex) {
          setState(() {
            _pageController.animateToPage(tappedIndex,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate);
          });
        },
        //type: BottomNavigationBarType.fixed,
      ),
    );
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
