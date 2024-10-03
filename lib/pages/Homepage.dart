import 'package:flutter/material.dart';
import 'Chatpage.dart';
import 'Previouspage.dart';
import 'Recordcase.dart';
import 'Notificationpage.dart';

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
                  // Navigate to NotificationsPage

                  print("Hello this is working");
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
    double progressPercentage = 0.40;

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
        Expanded(
          child: _buildActionButton('Add Case', Icons.add_circle_outline, Colors.blueAccent, context),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton('Previous Cases', Icons.check_circle_outline, Colors.blueAccent, context),
        ),
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
            width: double.infinity,
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
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CaseCard(
            caseTitle: 'Assault Case',
            dateAdded: '26/9/2024',
            status: 'Closed',
          ),
          CaseCard(
            caseTitle: 'Cybercrime Case',
            dateAdded: '26/9/2024',
            status: 'Closed',
          ),
        ],
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

// Notifications Page
class NotificationsPage extends StatelessWidget {
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
                  value: false, // manage state if needed
                  onChanged: (value) {
                    // Handle checkbox change
                  },
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
    return Container(
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
    );
  }
}
