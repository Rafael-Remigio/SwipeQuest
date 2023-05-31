import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRImage extends StatelessWidget {
  const QRImage(this.textSheet, {super.key});

  final String textSheet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + QR code'),
        centerTitle: true,
      ),
      body: Center(
        child: QrImageView(
          data: textSheet,
          size: 280,
          // You can include embeddedImageStyle Property if you
          //wanna embed an image from your Asset folder
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(
              100,
              100,
            ),
          ),
        ),
      ),
    );
  }
}
