import 'package:flutter/material.dart';
import '../main.dart';
import 'Recordcase.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Management System'),
        centerTitle: true,
      ),
      body: Center(
        child: _buildActionButtonsSection(context),
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
                Center( // Center the text
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 16, color: color),
                    textAlign: TextAlign.center, // Ensure text is centered
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
