import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  static List<String> announcements = ['23 May Project show'];

  final String name;

  const AnnouncementPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: announcements.map((announcement) {
          return Card(
            child: ListTile(
              title: Text(announcement),
            ),
          );
        }).toList(),
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
        currentIndex: 3, // Set the initial selected index
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
}
