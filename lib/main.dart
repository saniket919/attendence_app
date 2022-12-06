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
        primarySwatch: Colors.orange,
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
  List<String> students = [];

  // Map of student names to their attendance status
  // true: present, false: absent
  Map<String, bool> attendance = {};

  // Date to show attendance for
  DateTime date = DateTime.now();


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

  void removeStudent(String name) {
    setState(() {
      students.remove(name);
      attendance.remove(name);
    });
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
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    date = value;
                  });
                }
              });
            },
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
            secondary: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => removeStudent(student),
            ),
          );
        },
      ),
    );
  }
}