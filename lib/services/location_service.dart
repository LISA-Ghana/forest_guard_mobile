import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forest_guard/services/app_keys.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  LocationService._internal();
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;

  static LocationService get instance => _instance;

  final Dio _dio = Dio();

  Future<List> getRouteCoordinates(LatLng origin, LatLng destination) async {
    String url =
        'https://api.tomtom.com/routing/1/calculateRoute/${origin.latitude}%2C${origin.longitude}'
        '%3A${destination.latitude}%2C${destination.longitude}/json?avoid=unpavedRoads&key=${AppKeys.TOMTOM_API_KEY}';

    try {
      Response response = await _dio.get(url);
      Map values = response.data;
      return values['routes'][0]['legs'][0]['points'];
    } catch (e) {
      print('TomTom Error: ${e.toString()}');

      return null;
    }
  }

  Future<Position> getCurrentLocation() async {
    final enabled = await Geolocator.isLocationServiceEnabled();

    if (!enabled) {
      await Geolocator.openLocationSettings();

      return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}

class PolylineProvider extends ChangeNotifier {
  final markers = <Marker>{};
  final polyLines = <Polyline>{};
  GoogleMapController _controller;

  void initController(GoogleMapController controller) {
    _controller = controller;
  }

  void _createRoute(List encodedPoly) {
    polyLines.add(
      Polyline(
        polylineId: PolylineId(
          "Agent_Forest_Location",
        ),
        width: 5,
        points: _convertToLatLng(encodedPoly),
        color: Colors.black,
      ),
    );

    notifyListeners();
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      result.add(LatLng(points[i]['latitude'], points[i]['longitude']));
    }
    return result;
  }

  Future<void> drawPolylines() async {
    final bias = 0.1;

    final service = LocationService.instance;

    final position = await service.getCurrentLocation();

    if (position != null) {
      final encoded = await service.getRouteCoordinates(
        LatLng(position.latitude, position.longitude),
        LatLng(position.latitude + bias, position.longitude + bias),
      );

      if (encoded != null) {
        // Focus the map view on the user's location
        if (_controller != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: position.heading,
                target: LatLng(position.latitude, position.longitude),
                tilt: 59.440717697143555,
                zoom: 15,
              ),
            ),
          );
        }

        markers.addAll([
          Marker(
            markerId: MarkerId('UserLocation'),
            infoWindow: InfoWindow(
              title: 'My Location',
            ),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
          ),
          Marker(
            markerId: MarkerId('ActivityLocation'),
            infoWindow: InfoWindow(
                title: 'Detected Activity Location',
                snippet: 'Location of the detected activity'),
            position:
                LatLng(position.latitude + bias, position.longitude + bias),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
          ),
        ]);

        _createRoute(encoded);
      }
    }
  }
}
