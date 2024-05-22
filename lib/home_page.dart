import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'classes_page.dart';
import 'assignments_page.dart';

class HomePage extends StatelessWidget {
  final String name;
  const HomePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('EEEE').format(DateTime.now());
    final List<Map<String, String>> todayClasses =
        ClassesPage.classSchedule[today] ?? [];
    final int totalAssignments = AssignmentsPage.assignments.values
        .fold(0, (sum, assignmentList) => sum + assignmentList.length);
    final Map<String, String>? nextClass = getNextClass(todayClasses);

    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour >= 5 && hour < 12) {
      greeting = 'Good morning!';
    } else if (hour >= 12 && hour < 18) {
      greeting = "How's your day going so far?";
    } else if (hour >= 18 && hour < 19) {
      greeting = "I hope you're having a pleasant evening";
    } else {
      greeting = "Make sure to complete your assignments!";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.lightBlue,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/homeF.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hi $name!',
                  style: const TextStyle(
                    fontSize: 44,
                  ),
                ),
                const SizedBox(height: 40),
                Text(greeting, style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 30),
                if (nextClass != null)
                  Text(
                      "You have ${todayClasses.length} class'es today, $totalAssignments tasks pending"
                          .toUpperCase(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                nextClass != null
                    ? Text(
                        'Next class in ${nextClass['timeLeft']}:\n${nextClass['title']} in room ${nextClass['room']}',
                        style: const TextStyle(fontSize: 18),
                      )
                    : Text(
                        'No more classes for today, $totalAssignments tasks pending',
                        style: const TextStyle(fontSize: 18),
                      ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_outlined),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
        ],
        currentIndex: 0, // Set the initial selected index
        selectedItemColor: Colors.lightBlue, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        backgroundColor:
            Colors.white, // Background color of the bottom navigation bar
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home', arguments: {'name': name});
          } else if (index == 1) {
            Navigator.pushNamed(context, '/classes', arguments: {'name': name});
          } else if (index == 2) {
            Navigator.pushNamed(context, '/assignments',
                arguments: {'name': name});
          } else if (index == 3) {
            Navigator.pushNamed(context, '/announcements',
                arguments: {'name': name});
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
            '${difference.inHours} hours ${difference.inMinutes % 60} minutes';
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
