import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AttendancePage(),
    );
  }
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  // List of students in the class
  List<String> students = [    "Alice",    "Bob",    "Charlie",    "David",    "Eve",    "Frank",    "Gina",    "Harry",    "Ivy",    "Jack",  ];

  // Map of student names to their attendance status
  // true: present, false: absent
  Map<String, bool> attendance = {};

  @override
  void initState() {
    super.initState();

    // Set all students to absent by default
    for (var student in students) {
      attendance[student] = false;
    }
  }

  void addStudent() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Student"),
          content: TextField(
            onSubmitted: (name) {
              // Add the student to the list
              setState(() {
                students.add(name);
                attendance[name] = false;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addStudent,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          var student = students[index];
          return CheckboxListTile(
            value: attendance[student],
            title: Text(student),
            onChanged: (value) {
              setState(() {
                attendance[student] = value!;
              });
            },
          );
        },
      ),
    );
  }
}

