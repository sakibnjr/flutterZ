// home_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'classes_page.dart';
import 'assignments_page.dart';
import 'announcement_page.dart';

class HomePage extends StatelessWidget {
  final String name;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('EEEE').format(DateTime.now());
    final List<Map<String, String>> todayClasses =
        ClassesPage.classSchedule[today] ?? [];
    final int totalAssignments = AssignmentsPage.assignments.values
        .fold(0, (sum, assignmentList) => sum + assignmentList.length);
    final Map<String, String>? nextClass = getNextClass(todayClasses);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hi $name', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            nextClass != null
                ? Text(
                    'Next class in ${nextClass['timeLeft']}:\n${nextClass['title']} in room ${nextClass['room']}',
                    style: TextStyle(fontSize: 18),
                  )
                : Text(
                    'No more classes for today',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 10),
            Text(
                'You have ${todayClasses.length} class(es) today, $totalAssignments assignment(s) pending',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Classes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Assignments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement), label: 'Announcements'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/classes');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/assignments');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/announcements');
          }
        },
      ),
    );
  }

  Map<String, String>? getNextClass(List<Map<String, String>> classes) {
    DateTime now = DateTime.now();
    for (var classInfo in classes) {
      String time = classInfo['time']!;
      List<String> times = time.split(' - ');
      DateTime startTime = _convertToDateTime(times[0], now);
      if (startTime.isAfter(now)) {
        Duration difference = startTime.difference(now);
        String timeLeft =
            '${difference.inHours} hour(s) ${difference.inMinutes % 60} minute(s)';
        return {
          'title': classInfo['title']!,
          'room': classInfo['room']!,
          'timeLeft': timeLeft
        };
      }
    }
    return null;
  }

  DateTime _convertToDateTime(String time, DateTime now) {
    final DateFormat formatter = DateFormat('h:mm a');
    DateTime dateTime = formatter.parse(time);
    return DateTime(
        now.year, now.month, now.day, dateTime.hour, dateTime.minute);
  }
}
