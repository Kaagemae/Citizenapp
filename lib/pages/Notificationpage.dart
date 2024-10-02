import 'package:flutter/material.dart';

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
