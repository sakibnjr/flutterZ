import 'package:flutter/material.dart';

class ClassesPage extends StatelessWidget {
  static final Map<String, List<Map<String, String>>> classSchedule = {
    'Saturday': [],
    'Sunday': [
      {
        'title': 'System Analysis',
        'room': 'KT-213',
        'time': '8:30 AM - 09:45 AM'
      },
      {
        'title': 'Data Mining Lab',
        'room': 'G1-017',
        'time': '12:15 PM - 04:00 PM'
      },
      {
        'title': 'Data Mining Theory',
        'room': 'KT-201',
        'time': '04:00 PM - 05:15 PM'
      },
    ],
    'Monday': [
      {
        'title': 'Opeating Systems Lab',
        'room': 'G1-022',
        'time': '12:15 PM - 04:00 PM'
      },
      {
        'title': 'Pervasive Computing',
        'room': 'KT-216',
        'time': '04:00 PM - 05:15 PM'
      },
    ],
    'Tuesday': [
      {'title': 'Economics', 'room': 'KT-919', 'time': '08:30 AM - 09:45 AM'},
      {
        'title': 'System Analysis',
        'room': 'KT-515',
        'time': '11:00 AM - 12:15 PM'
      },
      {
        'title': 'Software Project V',
        'room': 'KT-804',
        'time': '04:00 PM - 05:15 PM'
      },
    ],
    'Wednesday': [
      {
        'title': 'Opeating Systems',
        'room': 'KT-223',
        'time': '08:30 AM - 09:45 AM'
      },
      {
        'title': 'Economics',
        'room': 'KT-318(B)',
        'time': '09:45 AM - 11:00 AM'
      },
    ],
    'Thursday': [
      {
        'title': 'Pervasive Computing Lab',
        'room': 'KT-501(A)',
        'time': '08:30 AM - 12:15 PM'
      },
      {
        'title': 'Data Mining Theory',
        'room': 'KT-305',
        'time': '01:30 PM - 02:45 PM'
      },
      {
        'title': 'Research & Innovation',
        'room': 'KT-304',
        'time': '02:45 PM - 04:00 PM'
      },
    ],
    'Friday': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Classes')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: classSchedule.keys.map((day) {
          return Card(
            child: ListTile(
              title: Text(day),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassDetailPage(day: day, classes: classSchedule[day]!),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ClassDetailPage extends StatelessWidget {
  final String day;
  final List<Map<String, String>> classes;

  ClassDetailPage({required this.day, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$day Classes')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: classes.map((classInfo) {
          return Card(
            child: ListTile(
              title: Text(classInfo['title']!),
              subtitle: Text(
                  'Room: ${classInfo['room']!}\nTime: ${classInfo['time']!}'),
            ),
          );
        }).toList(),
      ),
    );
  }
}
