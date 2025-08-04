import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final List<String> healthReminders = [
    '💧 Drink Water',
    '🏃‍♂️ Go for a Walk',
    '🥗 Eat a Balanced Meal',
    '🛏️ Sleep Early',
  ];

  final List<String> userNotes = [];
  final TextEditingController noteController = TextEditingController();

  void _addNote() {
    final note = noteController.text;
    if (note.isNotEmpty) {
      setState(() {
        userNotes.add(note);
        noteController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Reminder & Notes')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Health Reminders:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ...healthReminders.map(
              (reminder) => ListTile(title: Text(reminder)),
            ),
            Divider(),
            Text(
              'Your Notes:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ...userNotes.map((note) => ListTile(title: Text(note))),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Add a note'),
            ),
            ElevatedButton(onPressed: _addNote, child: Text('Save Note')),
          ],
        ),
      ),
    );
  }
}
