import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Swipe Quest',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Center(
            child: Text('X')
          ),
          Center(
            child: Text('Y')
          ),
        ]
      ),

      drawer: const Drawer(),
    );
  }
}
