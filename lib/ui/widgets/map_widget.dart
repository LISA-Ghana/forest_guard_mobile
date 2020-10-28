import 'package:flutter/material.dart';
import 'package:forest_guard/services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PolylineProvider>(
        builder: (_, provider, __) => GoogleMap(
          initialCameraPosition: CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(5.54981, -0.8507183),
            tilt: 59.440717697143555,
            zoom: 15,
          ),
          markers: provider.markers,
          polylines: provider.polyLines,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: false,
          zoomControlsEnabled: true,
          onMapCreated: (controller) {
            provider.initController(controller);
          },
        ),
      ),
    );
  }
}
