// admin_page.dart
import 'package:flutter/material.dart';
import 'classes_page.dart';
import 'assignments_page.dart';
import 'announcement_page.dart'; // Import the announcement page

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _classTitleController = TextEditingController();
  final TextEditingController _classRoomController = TextEditingController();
  final TextEditingController _classTimeController = TextEditingController();
  final TextEditingController _assignmentCourseController =
      TextEditingController();
  final TextEditingController _assignmentDetailController =
      TextEditingController();
  final TextEditingController _announcementController =
      TextEditingController(); // Controller for announcements
  String selectedDay = 'Saturday';
  String selectedSubject = 'Math';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
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
          children: [
            DropdownButton<String>(
              value: selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: ClassesPage.classSchedule.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _classTitleController,
              decoration: InputDecoration(labelText: 'Class Title'),
            ),
            TextField(
              controller: _classRoomController,
              decoration: InputDecoration(labelText: 'Class Room'),
            ),
            TextField(
              controller: _classTimeController,
              decoration: InputDecoration(labelText: 'Class Time'),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ClassesPage.classSchedule[selectedDay]?.add({
                        'title': _classTitleController.text,
                        'room': _classRoomController.text,
                        'time': _classTimeController.text,
                      });
                    });
                  },
                  child: Text('Add Class'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ClassesPage.classSchedule[selectedDay]?.removeWhere(
                          (classInfo) =>
                              classInfo['title'] ==
                                  _classTitleController.text &&
                              classInfo['room'] == _classRoomController.text &&
                              classInfo['time'] == _classTimeController.text);
                    });
                  },
                  child: Text('Remove Class'),
                ),
              ],
            ),
            TextField(
              controller: _assignmentCourseController,
              decoration: InputDecoration(labelText: 'Assignment Course'),
            ),
            TextField(
              controller: _assignmentDetailController,
              decoration: InputDecoration(labelText: 'Assignment Detail'),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String course = _assignmentCourseController.text;
                      String detail = _assignmentDetailController.text;
                      if (AssignmentsPage.assignments.containsKey(course)) {
                        AssignmentsPage.assignments[course]!.add(detail);
                      } else {
                        AssignmentsPage.assignments[course] = [detail];
                      }
                    });
                  },
                  child: Text('Add Assignment Detail'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String course = _assignmentCourseController.text;
                      String detail = _assignmentDetailController.text;
                      if (AssignmentsPage.assignments.containsKey(course)) {
                        AssignmentsPage.assignments[course]!.remove(detail);
                        if (AssignmentsPage.assignments[course]!.isEmpty) {
                          AssignmentsPage.assignments.remove(course);
                        }
                      }
                    });
                  },
                  child: Text('Remove Assignment Detail'),
                ),
              ],
            ),
            TextField(
              controller: _announcementController,
              decoration: InputDecoration(labelText: 'Announcement'),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      AnnouncementPage.announcements
                          .add(_announcementController.text);
                    });
                  },
                  child: Text('Add Announcement'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      AnnouncementPage.announcements
                          .remove(_announcementController.text);
                    });
                  },
                  child: Text('Remove Announcement'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Text('Class Schedule:'),
                  for (var entry in ClassesPage.classSchedule.entries)
                    Text(
                        '${entry.key}: ${entry.value.map((classInfo) => '${classInfo['title']} (${classInfo['room']}, ${classInfo['time']})').join(', ')}'),
                  SizedBox(height: 20),
                  Text('Assignments:'),
                  for (var entry in AssignmentsPage.assignments.entries)
                    Text('${entry.key}: ${entry.value.join(', ')}'),
                  SizedBox(height: 20),
                  Text('Announcements:'),
                  for (var announcement in AnnouncementPage.announcements)
                    Text(announcement),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
