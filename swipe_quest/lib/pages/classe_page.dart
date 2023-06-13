import 'package:flutter/material.dart';
import 'package:swipe_quest/components/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchClasses(String race) async {
  String url = "https://www.dnd5eapi.co/api/classes/" + race;

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // need to use utf8 decode because of special chars
    Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

    //debugPrint(posts.toString());
    return body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class DnDClassDetailsPage extends StatefulWidget {
  final String className;

  DnDClassDetailsPage({
    required this.className,
  });

  @override
  State<DnDClassDetailsPage> createState() =>
      _DnDClassDetailsPageState(className: className);
}

class _DnDClassDetailsPageState extends State<DnDClassDetailsPage> {
  final String className;

  _DnDClassDetailsPageState({
    required this.className,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        title: Text(widget.className.toUpperCase()),
      ),
      body: FutureBuilder(
          future: fetchClasses(className),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Starting Equipment Options',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            snapshot.data!["starting_equipment_options"][0]
                                ["desc"],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proficiency Choices',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            snapshot.data!["proficiency_choices"][0]["desc"],
                          ),
                        ],
                      ),
                    ), /*
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Size Description',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(snapshot.data!["size_description"]),
                        ],
                      ),
                    ),*/
                  ],
                ),
              );
            } else {
              return Scaffold(
                  backgroundColor: Color(0xFF1E1E1E),
                  body: const Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
