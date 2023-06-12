import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swipe_quest/components/app_colors.dart';
import 'package:swipe_quest/model/character.dart';

import '../provider/sheetBox.dart';
import 'package:provider/provider.dart';

import 'character_sheet.dart';

class CameraQrCode extends StatefulWidget {
  const CameraQrCode({super.key});

  @override
  State<CameraQrCode> createState() => _CameraQrCodeState();
}

class _CameraQrCodeState extends State<CameraQrCode>
    with SingleTickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      allowDuplicates: true,
      controller: cameraController,
      onDetect: _foundBarcode,
    );
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    /// open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      var jsonCodec = const JsonCodec();

      try {
        Character character = Character.fromJson(jsonCodec.decode(code));
        final sheetBox = Provider.of<SheetBox>(context, listen: false);
        sheetBox.put(character);

        _screenOpened = true;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CharacterPage(characterKey: "key_${character.name}"),
            ));
      } on Exception catch (e) {
        Fluttertoast.showToast(
            msg: 'Error Parsing QRCode',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: AppColors.black);
      }
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scanned Code:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
