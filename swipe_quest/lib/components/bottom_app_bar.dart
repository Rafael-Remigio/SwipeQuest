import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.onPressed, required Row child,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(
      onPressed: () {  },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}