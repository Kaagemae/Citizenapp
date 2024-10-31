import 'dart:convert';
import 'package:citizencasereportingapp/pages/uploadAndAttachLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NearbyStationPage(),
    );
  }
}

class NearbyStationPage extends StatelessWidget {
  const NearbyStationPage({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng? currentPosition; // Store current position here

    return Scaffold(
      body: Column(
        children: [
          // Top Image Section
          Image.asset(
            'Assets/Images/app.png',
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

          // Map Section
          Expanded(
            child: MapSample(
              onLocationChanged: (position) {
                currentPosition = position; // Update current position
              },
            ),
          ),

          // Button to Upload Evidence
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (currentPosition != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EvidenceUploadPage(
                        // locationName: "Current Location",
                        // latitude: currentPosition!.latitude,
                        // longitude: currentPosition!.longitude,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Current location not available.")),
                  );
                }
              },
              child: Text("Upload Evidence"),
            ),
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
  final Function(LatLng) onLocationChanged; // Callback for location updates

  const MapSample({super.key, required this.onLocationChanged}); // Accept the callback

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  LatLng? _currentPosition; // To store user location
  List<LatLng> _policeStations = []; // List of police stations

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permissions are permanently denied.")),
      );
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      widget.onLocationChanged(_currentPosition!); // Call the callback to pass location

      // Fetch police stations after getting current position
      _fetchPoliceStations(position.latitude, position.longitude);
    });
  }

  Future<void> _fetchPoliceStations(double lat, double lon) async {
    final overpassUrl =
        'https://overpass-api.de/api/interpreter?data=[out:json];node[amenity=police](around:5000,$lat,$lon);out;';

    try {
      final response = await http.get(Uri.parse(overpassUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the data from Overpass API
        List<LatLng> stations = [];
        for (var element in data['elements']) {
          double lat = element['lat'];
          double lon = element['lon'];
          stations.add(LatLng(lat, lon));
        }

        setState(() {
          _policeStations = stations; // Update the list of police stations
        });
      } else {
        throw Exception('Failed to load police stations');
      }
    } catch (e) {
      print('Error fetching police stations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load police stations")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _currentPosition ?? LatLng(-1.2921, 36.8219), // Default to Nairobi, Kenya
        initialZoom: 12.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            if (_currentPosition != null)
              Marker(
                point: _currentPosition!,
                child: Icon(Icons.my_location, color: Colors.red, size: 40),
              ),
            // Add markers for police stations
            ..._policeStations.map((station) => Marker(
              point: station,
              child: Icon(Icons.local_police, color: Colors.blue, size: 30),
            )),
          ],
        ),
      ],
    );
  }
}
