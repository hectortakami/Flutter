// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final String coords = ModalRoute.of(context)?.settings.arguments as String;
    final lat = double.parse(coords.split(':')[1].split(',')[0]);
    final lng = double.parse(coords.split(':')[1].split(',')[1]);

    final CameraPosition mapPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 17.5,
      tilt: 50,
    );

    final Set<Marker> markerList = <Marker>{};
    markerList.add(
      Marker(
        markerId: MarkerId('geo-marker'),
        position: LatLng(lat, lng),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Map Page'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(mapPosition));
            },
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        initialCameraPosition: mapPosition,
        markers: markerList,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.hybrid;
          } else {
            mapType = MapType.normal;
          }
          setState(() {});
        },
      ),
    );
  }
}
