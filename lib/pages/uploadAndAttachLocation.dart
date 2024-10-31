import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class EvidenceUploadPage extends StatefulWidget {
  const EvidenceUploadPage({super.key});

  @override
  _EvidenceUploadPageState createState() => _EvidenceUploadPageState();
}

class _EvidenceUploadPageState extends State<EvidenceUploadPage> {
  String _locationName = "Fetching location...";
  double? _latitude;
  double? _longitude;
  String? _uploadedFileName;
  String? _capturedImageName;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
        await _getLocationName(_latitude!, _longitude!);
      } else {
        setState(() {
          _locationName = "Location permission denied";
        });
      }
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        _locationName = "Error getting location";
      });
    }
  }

  Future<void> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _locationName = "${place.locality}, ${place.subLocality}, ${place.country}"; // More specific location
        });
        print("Location Name: $_locationName");
      } else {
        setState(() {
          _locationName = "No location found";
        });
      }
    } catch (e) {
      print("Error getting location name: $e");
      setState(() {
        _locationName = "Location not found";
      });
    }
  }

  Future<void> _uploadDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;
      setState(() {
        _uploadedFileName = file.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Uploaded: ${file.name}'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No document selected'),
      ));
    }
  }

  Future<void> _useCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _capturedImageName = photo.name;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Captured Image: ${photo.name}'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No image captured'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Evidence"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location: $_locationName",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_latitude != null && _longitude != null) ...[
              Text("Latitude: $_latitude"),
              Text("Longitude: $_longitude"),
            ],
            SizedBox(height: 20),

            // Upload section with icon and instruction
            GestureDetector(
              onTap: _uploadDocument,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file, size: 30, color: Colors.blue),
                      const SizedBox(height: 8),
                      Text(
                        _uploadedFileName != null
                            ? 'Uploaded: $_uploadedFileName'
                            : 'Tap to upload a document',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Use Camera Button
            ElevatedButton.icon(
              onPressed: _useCamera,
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: const Text('Use Camera'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.amber, // text color
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_capturedImageName != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Captured Image: $_capturedImageName', style: TextStyle(color: Colors.black)),
              ),

            const Spacer(), // Pushes the submit button to the bottom
          ],
        ),
      ),

      // Centered Submit Button with additional space
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter, // Center the button horizontally
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0), // Add padding to the bottom
          child: FloatingActionButton.extended(
            onPressed: () {
              // Implement submission functionality here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Evidence submitted successfully!")),
              );
              Navigator.of(context).pop(); // Navigate back after submission
            },
            label: const Text(
              "Submit Evidence",
              style: TextStyle(color: Colors.white), // Set text color to white for contrast
            ),
            icon: const Icon(Icons.check, color: Colors.white), // Set icon color to white for contrast
            backgroundColor: Colors.blue, // Set the background color to blue
          ),
        ),
      ),
    );
  }
}
