import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng? poiLocation;

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
        // Aqui você pode exibir uma mensagem ou tomar ações apropriadas para lidar com a permissão negada
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // O usuário negou permanentemente a permissão de localização, trate o caso adequadamente
      // Aqui você pode exibir uma mensagem ou tomar ações apropriadas para lidar com a permissão negada permanentemente
      return;
    }

    // Obtenha a posição atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      poiLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body: (poiLocation != null)
          ? GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: poiLocation!,
                zoom: 15.0,
              ),
              markers: Set<Marker>.of([
                Marker(
                  markerId: MarkerId('poiMarker'),
                  position: poiLocation!,
                  infoWindow: InfoWindow(
                    title: 'Ponto de Interesse',
                  ),
                ),
              ]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
