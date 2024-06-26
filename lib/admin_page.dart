import 'package:flutter/material.dart';
import 'classes_page.dart';
import 'assignments_page.dart';
import 'announcement_page.dart'; // Import the announcement page

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
        title: const Text(
          'Admin Page',
          style: TextStyle(
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.redAccent),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              decoration: const InputDecoration(labelText: 'Class Title'),
            ),
            TextField(
              controller: _classRoomController,
              decoration: const InputDecoration(labelText: 'Class Room'),
            ),
            TextField(
              controller: _classTimeController,
              decoration: const InputDecoration(labelText: 'Class Time'),
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
                  child: const Text('Add Class'),
                ),
                const SizedBox(width: 10),
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
                  child: const Text('Remove Class'),
                ),
              ],
            ),
            TextField(
              controller: _assignmentCourseController,
              decoration: const InputDecoration(labelText: 'Assignment Course'),
            ),
            TextField(
              controller: _assignmentDetailController,
              decoration: const InputDecoration(labelText: 'Assignment Detail'),
            ),
            Wrap(
              children: [
                Wrap(
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
                      child: const Text('Add Assignment'),
                    ),
                    const SizedBox(width: 10),
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
                      child: const Text('Remove Assignment'),
                    ),
                  ],
                ),
              ],
            ),
            TextField(
              controller: _announcementController,
              decoration: const InputDecoration(labelText: 'Announcement'),
            ),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      AnnouncementPage.announcements
                          .add(_announcementController.text);
                    });
                  },
                  child: const Text('Add New'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      AnnouncementPage.announcements
                          .remove(_announcementController.text);
                    });
                  },
                  child: const Text('Remove Selected'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Class Schedule:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...ClassesPage.classSchedule.entries.map((entry) {
              return Text(
                  '${entry.key}: ${entry.value.map((classInfo) => '${classInfo['title']} (${classInfo['room']}, ${classInfo['time']})').join(', ')}');
            }).toList(),
            const SizedBox(height: 20),
            const Text('Assignments:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...AssignmentsPage.assignments.entries.map((entry) {
              return Text('${entry.key}: ${entry.value.join(', ')}');
            }).toList(),
            const SizedBox(height: 20),
            const Text('Announcements:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...AnnouncementPage.announcements.map((announcement) {
              return Text(announcement);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
