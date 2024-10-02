import 'package:citizencasereportingapp/pages/Chatpage.dart';
import 'package:citizencasereportingapp/pages/Nearbystations.dart';
import 'package:citizencasereportingapp/pages/Previouspage.dart';
import 'package:citizencasereportingapp/pages/Recordcase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Casereportingapp());
}

class Casereportingapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define named routes
      routes: {
        '/': (context) => SignInPage(), // Default route
        '/dashboard': (context) => DashboardPage(),
        '/RecordCasePage': (context) => RecordCasePage(),
        '/uploaddocument': (context) => const UploadDocumentPage(),
        '/Previouscase': (context) => PreviousCasesPage(),
      },
      initialRoute: '/', // Set the initial route
    );
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome message
            const Text(
              'Welcome Back !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            const Text(
              'Sign in to continue',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            // Full name input field
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Full Name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ID number input field
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter ID Number',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Sign up button
            SizedBox(
              width: double.infinity, // Full width button
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the dashboard page using pushNamed
                  Navigator.pushNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ), // Button color
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashboard Page with Scrollable Case Cards
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsPage()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '5',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Personal Info and Case Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildPersonalInfoSection(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: _buildCaseProgressSection(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildActionButtonsSection(context), // Buttons for Add Case and Previous Cases
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Previous Cases',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 14),
            _buildCaseCardsSection(), // Previous cases list
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'CASES',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reports',
          ),
        ],
      ),
    );
  }

  // Personal Info Section
  Widget _buildPersonalInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Personal Info',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Jane Doe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('ID NO: 3467578686'),
          Text('D.O.B: 21/7/2024'),
          Text('Nationality: Kenyan'),
        ],
      ),
    );
  }

  // Case Progress Section
  Widget _buildCaseProgressSection() {
    double progressPercentage = 0.0;

    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'My Case Progress',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progressPercentage,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(progressPercentage == 1.0 ? Colors.green : Colors.red),
                ),
              ),
              Text(
                '${(progressPercentage * 100).toInt()}%',
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Action Buttons Section (Add Case, Previous Cases)
  Widget _buildActionButtonsSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('Add Case', Icons.add_circle_outline, Colors.blueAccent, context),
        _buildActionButton('Previous Cases', Icons.check_circle_outline, Colors.blueAccent, context),
      ],
    );
  }

  // Reusable Action Button Widget
  Widget _buildActionButton(String label, IconData icon, Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == 'Add Case') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecordCasePage()),
          );
        } else if (label == 'Previous Cases') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PreviousCasesPage()),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: 50,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Previous Case Cards Section
  Widget _buildCaseCardsSection() {
    List<Map<String, dynamic>> previousCases = [
      {'title': 'Case 1: Theft Incident', 'date': 'Jan 15, 2024', 'status': 'Open'},
      {'title': 'Case 2: Burglary Report', 'date': 'Feb 5, 2024', 'status': 'Closed'},
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: previousCases.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(previousCases[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(previousCases[index]['date']),
              trailing: Text(previousCases[index]['status']),
            ),
          );
        },
      ),
    );
  }
}

// Placeholder for the RecordCasePage
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

// Placeholder for the PreviousCasesPage


// Placeholder for the UploadDocumentPage
class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
      ),
      body: Center(
        child: const Text('Upload Document Page'),
      ),
    );
  }
}

// Placeholder for the NotificationsPage
class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _markAllAsRead = false;

  void _toggleMarkAllAsRead(bool? value) {
    setState(() {
      _markAllAsRead = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: _markAllAsRead,
                  onChanged: _toggleMarkAllAsRead,
                ),
                Text('Mark all as Read'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildNotificationTile(
                  context,
                  Icons.error,
                  '2 Oct 2024',
                  'Please attach evidence as requested earlier for the investigation to progress',
                  Colors.red.shade100,
                  Colors.red,
                ),
                _buildNotificationTile(
                  context,
                  Icons.message,
                  '2 Oct 2024',
                  'You have a new message from Inspector Swaleh',
                  Colors.green.shade100,
                  Colors.green,
                ),
                _buildNotificationTile(
                  context,
                  Icons.notification_important,
                  '2 Oct 2024',
                  'Please come to the station to confirm if the items retrieved are yours',
                  Colors.yellow.shade100,
                  Colors.yellow,
                ),
                _buildNotificationTile(
                  context,
                  Icons.notification_important,
                  '2 Oct 2024',
                  'Your case has been assigned to Inspector Kennedy',
                  Colors.yellow.shade100,
                  Colors.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
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
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
        ],
        currentIndex: 0, // manage the index dynamically
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle bottom nav taps
        },
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, IconData icon, String date,
      String message, Color backgroundColor, Color iconColor) {
    // Check if the message is from Inspector Swaleh
    final isInspectorMessage = message.contains('Inspector Swaleh');

    return GestureDetector(
      onTap: () {
        if (isInspectorMessage) {
          // Navigate to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 40),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
