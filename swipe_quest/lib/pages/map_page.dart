import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  final LatLng poiLocation = LatLng(37.7749, -122.4194); // Coordenadas do ponto de interesse

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: poiLocation,
          zoom: 15.0,
        ),
        markers: Set<Marker>.of([
          Marker(
            markerId: MarkerId('poiMarker'),
            position: poiLocation,
            infoWindow: InfoWindow(
              title: 'Ponto de Interesse',
            ),
          ),
        ]),
      ),
    );
  }
}
