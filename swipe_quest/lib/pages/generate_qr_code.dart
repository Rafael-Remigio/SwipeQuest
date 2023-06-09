import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/character.dart';
import 'dart:convert';

class QRImage extends StatelessWidget {
  const QRImage(this.character, {super.key});

  final Character character;
  final json = const JsonCodec();
  @override
  Widget build(BuildContext context) {
    character.rolsHistory = List.empty(growable: true);
    var encoded = json.encode(character.toJson());

    return Center(
      child: QrImageView(
        data: encoded,
        size: 280,
        // You can include embeddedImageStyle Property if you
        //wanna embed an image from your Asset folder
        embeddedImageStyle: const QrEmbeddedImageStyle(
          size: Size(
            100,
            100,
          ),
        ),
      ),
    );
  }
}
