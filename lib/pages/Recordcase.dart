import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class RecordCaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecordCasePage(),
    );
  }
}

class RecordCasePage extends StatefulWidget {
  @override
  _RecordCasePageState createState() => _RecordCasePageState();
}

class _RecordCasePageState extends State<RecordCasePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedStation;
  String? selectedCaseType;
  String? fullName;
  String? idNumber;
  DateTime? reportedDate;
  String? stake;
  String? caseDescription;
  String? obNumber;
  PlatformFile? uploadedFile;

  // Sample OB number generation
  String generateObNumber() {
    return "#${DateTime.now().millisecondsSinceEpoch}A";
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        obNumber = generateObNumber();
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(
            fullName: fullName!,
            policeStation: selectedStation!,
            obNumber: obNumber!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record A Case'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Police station dropdown
              buildDropdownButtonFormField(
                label: 'Police Station',
                value: selectedStation,
                items: [
                  'Riruta Police Station',
                  'Kabete Police Station',
                  'Mutuini Police Station',
                  'Satellite Police Station'
                ],
                onChanged: (value) {
                  setState(() {
                    selectedStation = value;
                  });
                },
              ),
              SizedBox(height: 16),
              // Case type dropdown
              buildDropdownButtonFormField(
                label: 'Case Type',
                value: selectedCaseType,
                items: ['Theft', 'Accident', 'Assault'],
                onChanged: (value) {
                  setState(() {
                    selectedCaseType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Full name input
              buildTextFormField(
                label: 'Reported By',
                onSaved: (value) => fullName = value,
              ),
              const SizedBox(height: 16),
              // ID Number input
              buildTextFormField(
                label: 'ID Number',
                onSaved: (value) => idNumber = value,
              ),
              const SizedBox(height: 16),
              // Date input
              buildTextFormField(
                label: 'Date Reported (DD/MM/YYYY)',
                onSaved: (value) => reportedDate = DateTime.now(),
              ),
              const SizedBox(height: 16),
              // Stake input
              buildTextFormField(
                label: 'Stake',
                onSaved: (value) => stake = value,
              ),
              const SizedBox(height: 16),
              // Case description input
              buildTextFormField(
                label: 'Case Description',
                onSaved: (value) => caseDescription = value,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              // File upload button
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to UploadDocumentPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadDocumentPage(),
                    ),
                  ).then((value) {
                    if (value is PlatformFile) {
                      setState(() {
                        uploadedFile = value; // Update uploaded file
                      });
                    }
                  });
                },
                icon: Icon(Icons.upload_file),
                label: Text(uploadedFile != null ? uploadedFile!.name : 'Attach Evidence'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(height: 24),
              // Submit button
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build dropdown fields
  Widget buildDropdownButtonFormField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }

  // Helper function to build text fields
  Widget buildTextFormField({
    required String label,
    required void Function(String?) onSaved,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: onSaved,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      maxLines: maxLines,
    );
  }
}

class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({Key? key}) : super(key: key);

  Future<void> _uploadDocument(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Uploaded: ${file.name}'),
      ));
      Navigator.pop(context, file); // Pass back the selected file
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No document selected'),
      ));
      Navigator.pop(context); // Go back if no file is selected
    }
  }

  Future<void> _useCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Captured Image: ${photo.name}'),
      ));
      Navigator.pop(context); // Go back after capturing the image
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No image captured'),
      ));
    }
  }

  void _submit() {
    // Add submission logic here
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Upload section with icon and instruction
            GestureDetector(
              onTap: () => _uploadDocument(context),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.upload_file, size: 50, color: Colors.blue),
                    const SizedBox(height: 16),
                    RichText(
                      text: const TextSpan(
                        text: 'Drop your file(s) here, or ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Browse',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Use Camera Button
            ElevatedButton.icon(
              onPressed: () => _useCamera(context),
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: const Text('Use Camera'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.amber, // text color
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const Spacer(), // Pushes the submit button to the bottom

            // Submit Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: double.infinity, // Full width button
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String fullName;
  final String policeStation;
  final String obNumber;

  const ConfirmationPage({
    Key? key,
    required this.fullName,
    required this.policeStation,
    required this.obNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dear $fullName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    const TextSpan(text: 'Your case has been filed at '),
                    TextSpan(
                      text: policeStation,
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' and your OB Number is '),
                    TextSpan(
                      text: obNumber,
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
