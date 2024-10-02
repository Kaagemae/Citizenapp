import 'package:flutter/material.dart';

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
