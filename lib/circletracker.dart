import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CycleTracker extends StatefulWidget {
  const CycleTracker({super.key});
  @override
  _CycleTrackerState createState() => _CycleTrackerState();
}

class _CycleTrackerState extends State<CycleTracker> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTime> _periodDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Cycle Tracker')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => _selectedDay == day,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _periodDates.add(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _periodDates.length,
              itemBuilder: (context, index) {
                final date = _periodDates[index];
                return ListTile(
                  title: Text('Logged date: ${date.toLocal()}'.split(' ')[0]),
                  trailing: Icon(Icons.circle, color: Colors.pinkAccent),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
