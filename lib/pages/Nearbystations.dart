import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Image Section
          Image.asset(
            'assets/images/location_image.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),

          // Location Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Location",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "Stations nearby (1)",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),

          // Google Map Section
          Expanded(
            child: MapSample(), // The map widget
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reports',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController? mapController;
  LatLng? _currentPosition;  // To store user location
  LatLng? _nearestStation;   // To store nearest police station location
  final List<LatLng> _policeStations = [
    LatLng(-1.28333, 36.81667), // Example: Police Station 1
    LatLng(-1.29207, 36.82195), // Example: Police Station 2
    LatLng(-1.30000, 36.80000), // Example: Police Station 3
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get user current location
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _nearestStation = _findNearestStation(_currentPosition!);
    });
  }

  // Find nearest police station using simple distance comparison
  LatLng _findNearestStation(LatLng userLocation) {
    LatLng nearestStation = _policeStations.first;
    double minDistance = _calculateDistance(userLocation, nearestStation);

    for (var station in _policeStations) {
      double distance = _calculateDistance(userLocation, station);
      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = station;
      }
    }
    return nearestStation;
  }

  // Haversine formula to calculate distance between two coordinates
  double _calculateDistance(LatLng start, LatLng end) {
    const earthRadius = 6371; // Radius of Earth in kilometers
    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLng = _degreesToRadians(end.longitude - start.longitude);
    double a =
        (sin(dLat / 2) * sin(dLat / 2)) +
            cos(_degreesToRadians(start.latitude)) * cos(_degreesToRadians(end.latitude)) *
                (sin(dLng / 2) * sin(dLng / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? Center(child: CircularProgressIndicator())
        : GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: _currentPosition!,
        zoom: 14.0,
      ),
      markers: _createMarkers(),
    );
  }

  Set<Marker> _createMarkers() {
    final Set<Marker> markers = {};

    // Marker for the current location
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: _currentPosition!,
          infoWindow: InfoWindow(
            title: 'You are here',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    // Marker for the nearest police station
    if (_nearestStation != null) {
      markers.add(
        Marker(
          markerId: MarkerId('nearestStation'),
          position: _nearestStation!,
          infoWindow: InfoWindow(
            title: 'Nearest Police Station',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    return markers;
  }
}
