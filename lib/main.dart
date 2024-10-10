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
        '/': (context) => LoginPage(), // Default route
        '/dashboard': (context) => DashboardPage(),
        '/signup': (context) => SignUpPage(),
        '/RecordCasePage': (context) => RecordCasePage(),
        '/uploaddocument': (context) => const UploadDocumentPage(),
        '/Previouscase': (context) => PreviousCasesPage(),
      },
      initialRoute: '/', // Set the initial route
    );
  }
}
class LoginPage extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50), // Top spacing
            Image.asset(
              'Assets/Images/Loginpage.png', // Replace with your image path
              width: 150, // Set width as needed
              height: 200,
              fit: BoxFit.contain,// Set height as needed
            ),
            SizedBox(height: 20),
            Text(
              "Welcome Back !",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: 'Enter ID Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                Text('Remember me'),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Forgot password logic
                  },
                  child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Home Page after successful login
                Navigator.pushNamed(context, '/dashboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15), // Button size
              ),
              child: Text('SIGN IN'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to Sign Up Page
                Navigator.pushNamed(context, '/signup');
              },
              child: Text("Do not have an account? Sign Up", style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Emergency report logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Button size
              ),
              child: Text('EMERGENCY REPORT'),
            ),
          ],
        ),
      ),
    );
  }
}


class SignUpPage extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100), // Top spacing
            Text(
              "Welcome",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              "Register to continue",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                hintText: 'Enter Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: 'Enter ID Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Enter Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sign-up logic here
                // After signing up, navigate to dashboard or login
                Navigator.pushNamed(context, '/dashboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15), // Button size
              ),
              child: Text('SIGN UP'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate back to Login page
                Navigator.pop(context);
              },
              child: Text("Have an account? Sign In", style: TextStyle(color: Colors.blue)),
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
            // Previouscases list
            SizedBox(height: 150,child: _buildCaseCardsSection()),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Info',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
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
      width: 160,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0), // Adding padding to move text to the right
            child: Text(
              'My Case Progress',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 8),
                Text(label, style: TextStyle(fontSize: 16, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Previous Cases Section
  Widget _buildCaseCardsSection() {
    return Flexible(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight * 0.6;

          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: const CaseCard(
                  caseTitle: 'Assault Case',
                  dateAdded: '26/9/2024',
                  status: 'Closed',
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: const CaseCard(
                  caseTitle: 'Cybercrime Case',
                  dateAdded: '26/9/2024',
                  status: 'Closed',
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: const CaseCard(
                  caseTitle: 'Cybercrime Case',
                  dateAdded: '26/9/2024',
                  status: 'Closed',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Case Card Widget for Previous Cases
class CaseCard extends StatelessWidget {
  final String caseTitle;
  final String dateAdded;
  final String status;

  const CaseCard({
    Key? key,
    required this.caseTitle,
    required this.dateAdded,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caseTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            dateAdded,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: status == 'Closed' ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              status,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
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


class PreviousCasesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Cases'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCaseCard(
              caseTitle: 'Missing Person case',
              dateReported: '26/9/2024',
              reporter: 'Jane Doe',
              progress: 0.0,
              status: 'New Case',
            ),
            _buildCaseCard(
              caseTitle: 'Traffic case',
              dateReported: '26/9/2024',
              reporter: 'Jane Doe',
              progress: 0.52,
              status: 'Case in progress',
            ),
            _buildCaseCard(
              caseTitle: 'Assault case',
              dateReported: '26/9/2024',
              reporter: 'Jane Doe',
              progress: 0.52,
              status: 'Case in progress',
            ),
            _buildCaseCard(
              caseTitle: 'Traffic case',
              dateReported: '26/9/2024',
              reporter: 'Jane Doe',
              progress: 1.0,
              status: 'Case closed',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.task),
            label: 'TASKS',
          ),
        ],
      ),
    );
  }

  Widget _buildCaseCard({
    required String caseTitle,
    required String dateReported,
    required String reporter,
    required double progress,
    required String status,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular progress indicator for case progress
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: progress, // Set the progress value (0.0 to 1.0)
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(progress == 1.0 ? Colors.green : Colors.blue),
                    strokeWidth: 5,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%', // Show percentage in the center
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Case details (title, reporter, date)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caseTitle,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reported on $dateReported',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Reported by $reporter',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status,
                    style: TextStyle(
                      color: status == 'Case closed' ? Colors.green : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Three-dot action menu
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Handle more actions
              },
            ),
          ],
        ),
      ),
    );
  }
}


// Placeholder for the UploadDocumentPage
class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
      ),
      body: const Center(
        child: Text('Upload Document Page'),
      ),
    );
  }
}

// Placeholder for the NotificationsPage
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                  value: false, // manage state if needed
                  onChanged: (value) {
                    // Handle checkbox change
                  },
                ),
                const Text('Mark all as Read'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap, if needed
                  },
                  child: _buildNotificationTile(
                    context,
                    Icons.error,
                    '2 Oct 2024',
                    'Please attach evidence as requested earlier for the investigation to progress',
                    Colors.red.shade100,
                    Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap, if needed
                  },
                  child: _buildNotificationTile(
                    context,
                    Icons.message,
                    '2 Oct 2024',
                    'You have a new message from Inspector Swaleh',
                    Colors.green.shade100,
                    Colors.green,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to ChatPage when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(),
                      ),
                    );
                  },
                  child: _buildNotificationTile(
                    context,
                    Icons.notification_important,
                    '2 Oct 2024',
                    'Please come to the station to confirm if the items retrieved are yours',
                    Colors.yellow.shade100,
                    Colors.yellow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle tap, if needed
                  },
                  child: _buildNotificationTile(
                    context,
                    Icons.notification_important,
                    '2 Oct 2024',
                    'Your case has been assigned to Inspector Kennedy',
                    Colors.yellow.shade100,
                    Colors.yellow,
                  ),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 40),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
