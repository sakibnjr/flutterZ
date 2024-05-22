// announcement_page.dart
import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  static List<String> announcements = ['23 May Project show'];

  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
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
    );
  }
}
