import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  List<Waypoint> waypoints = [];

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está ativado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Serviço de localização desativado, trate o caso adequadamente
      return;
    }

    // Verifica se o aplicativo tem permissão para acessar a localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permissão negada, solicite permissão ao usuário
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissão negada pelo usuário, trate o caso adequadamente
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // O usuário negou permanentemente a permissão de localização, trate o caso adequadamente
      return;
    }

    // Obtenha a posição atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    // Adicione os waypoints próximos com nomes de campanhas de RPG de mesa
    addWaypoints();
  }

void addWaypoints() {
  if (currentLocation != null) {
    double latitude = currentLocation!.latitude;
    double longitude = currentLocation!.longitude;

    Random random = Random();

    List<String> funnyNames = [
      'Aventura dos Bobos Alegres',
      'O Resgate da Salsicha Mágica',
      'A Incrível Jornada dos Cogumelos Saltitantes',
      'A Missão dos Pinguins Dançantes',
      'A Busca pelo Unicórnio Sorridente',
      'O Tesouro Escondido no Nariz do Palhaço',
      'A Expedição dos Macacos Malucos',
      'A Lenda dos Cachorros Falantes',
      'A Vingança das Cenouras Assassinas',
      'A Procura do Chapéu Desaparecido',
      'O Mistério do Sapato Voador',
      'A Aventura dos Biscoitos Saltitantes',
      'A Jornada dos Gatos Risonhos',
      'O Desafio dos Pinguins Surfistas',
      'O Encontro dos Alienígenas Amigáveis',
      'A Caça ao Tesouro nas Montanhas de Gelatina',
      'A Busca pelo Anão Desaparecido',
      'A Aventura dos Pandas Malabaristas',
      'O Mistério da Pizza Desaparecida',
      'A Vingança dos Tomates Mutantes',
    ];

    List<String> selectedNames = [];
    int count = 0;

    while (count < 3) {
      String randomName = funnyNames[random.nextInt(funnyNames.length)];

      if (!selectedNames.contains(randomName)) {
        selectedNames.add(randomName);

        double randomLat = latitude + (random.nextDouble() * 0.002 - 0.001);
        double randomLng = longitude + (random.nextDouble() * 0.002 - 0.001);

        waypoints.add(Waypoint(
          name: randomName,
          position: LatLng(randomLat, randomLng),
        ));

        count++;
      }
    }

    setState(() {
      waypoints = waypoints;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (currentLocation != null)
          ? GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 15.0,
              ),
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: currentLocation!,
                  infoWindow: InfoWindow(
                    title: 'Localização Atual',
                  ),
                ),
                ...waypoints.map((waypoint) {
                  return Marker(
                    markerId: MarkerId(waypoint.position.toString()),
                    position: waypoint.position,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    infoWindow: InfoWindow(
                      title: waypoint.name,
                    ),
                  );
                }).toSet(),
              ]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Waypoint {
  final String name;
  final LatLng position;

  Waypoint({required this.name, required this.position});
}
