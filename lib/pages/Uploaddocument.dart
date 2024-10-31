import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';

class EvidenceUploadPage extends StatefulWidget {
  const EvidenceUploadPage({super.key});

  @override
  _EvidenceUploadPageState createState() => _EvidenceUploadPageState();
}

class _EvidenceUploadPageState extends State<EvidenceUploadPage> {
  String? _currentLocation; // To store the current location
  String? _uploadedFileName; // To store the name of the uploaded file
  String? _capturedImageName; // To store the name of the captured image

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get the current location when the widget is initialized
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    // When we reach here, permissions are granted and we can get the location.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = "${position.latitude}, ${position.longitude}"; // Store the current location
    });
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
              "Current Location: ${_currentLocation ?? 'Fetching location...'}", // Display the current location
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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

      // Submit Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implement submission functionality here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Evidence submitted successfully!")),
          );
          Navigator.of(context).pop(); // Navigate back after submission
        },
        label: const Text("Submit Evidence"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
//
// class UploadDocumentPage extends StatelessWidget {
//   const UploadDocumentPage({super.key});
//
//   Future<void> _uploadDocument(BuildContext context) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       final file = result.files.first;
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Uploaded: ${file.name}'),
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('No document selected'),
//       ));
//     }
//   }
//
//   Future<void> _useCamera(BuildContext context) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? photo = await picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Captured Image: ${photo.name}'),
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('No image captured'),
//       ));
//     }
//   }
//
//   String generateObNumber() {
//     // Generate a unique OB number
//     return "#${DateTime.now().millisecondsSinceEpoch}A";
//   }
//
//   void _submit(BuildContext context) {
//     // Generate OB number
//     String obNumber = generateObNumber();
//
//     // Show a popup message with the police station and OB number
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Submission Successful'),
//           content: Text(
//             'Your OB Number is: $obNumber\n\n'
//                 'Please report to the nearest police station for further assistance.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upload Document'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Go back to the previous page
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             // Upload section with icon and instruction
//             GestureDetector(
//               onTap: () => _uploadDocument(context),
//               child: Container(
//                 padding: const EdgeInsets.all(16.0),
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.upload_file, size: 50, color: Colors.blue),
//                     const SizedBox(height: 16),
//                     RichText(
//                       text: const TextSpan(
//                         text: 'Drop your file(s) here, or ',
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: 'Browse',
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Use Camera Button
//             ElevatedButton.icon(
//               onPressed: () => _useCamera(context),
//               icon: const Icon(Icons.camera_alt, color: Colors.white),
//               label: const Text('Use Camera'),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.amber, // text color
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//
//             const Spacer(), // Pushes the submit button to the bottom
//
//             // Submit Button
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: SizedBox(
//                 width: double.infinity, // Full width button
//                 child: ElevatedButton(
//                   onPressed: () => _submit(context),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue, // Text color
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8), // Rounded corners
//                     ),
//                   ), // Pass context to submit
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Cases',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.task),
//             label: 'Tasks',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//       ),
//     );
//   }
// }
