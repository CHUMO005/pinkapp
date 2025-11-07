import 'package:flutter/material.dart';
import 'package:pink_app/bmipage.dart';
import 'package:pink_app/circletracker.dart';
import 'package:pink_app/reminderpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        119,
        5,
        68,
      ), // Background color matching the login page.
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          119,
          5,
          68,
        ), // Deep blue color for the app bar.
        elevation: 0, // No shadow for the app bar.
        automaticallyImplyLeading:
            false, // Removes the back arrow from the app bar.
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ), // Horizontal padding for the body.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Align children to the start of the column.
          children: [
            _upperText(), // Greeting section.
            _lowerScreenButtons(context), // Grid menu section.
          ],
        ),
      ),
    );
  }

  // Grid Menu Section
  Widget _lowerScreenButtons(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3, // Number of columns in the grid.
        crossAxisSpacing: 15, // Spacing between columns.
        mainAxisSpacing: 15, // Spacing between rows.
        children: [
          _buildMenuItem(
            Icons.swap_horiz,
            'Cycle Tracker',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CycleTracker()),
            ),
          ),

          _buildMenuItem(
            Icons.health_and_safety,
            'Your BMI',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Bmipage()),
            ),
          ),
          _buildMenuItem(
            Icons.notifications_active,
            'Remainder!',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReminderPage()),
            ),
          ),
        ],
      ),
    );
  }

  // Menu Item Widget (Styled like Login Page)
  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Action to perform when the item is tapped.
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the content vertically.
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(
              255,
              173,
              16,
              126,
            ), // Background color matching the login page fields.
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 82, 53, 16),
              size: 30,
            ), // Orange accent icon.
          ),
          const SizedBox(height: 10), // Spacing between icon and label.
          Text(
            label,
            textAlign: TextAlign.center, // Center the text.
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// Greeting Section
Widget _upperText() {
  return const Padding(
    padding: EdgeInsets.only(top: 20.0), // Padding at the top.
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start.
      children: [
        Text(
          'Welcome Here',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Vee!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.orangeAccent,
          ),
        ),
        SizedBox(height: 20), // Spacing between texts.
      ],
    ),
  );
}
