import 'package:flutter/material.dart';
import 'Contacts.dart';
import 'Notes.dart';
import 'Appointments.dart';
import 'Tasks.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Book"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: "Appointments", icon:  Icon(Icons.calendar_today_outlined)),
              Tab(text: "Contacts", icon: Icon(Icons.contacts_outlined)),
              Tab(text: "Notes", icon: Icon(Icons.note_outlined)),
              Tab(text: "Tasks", icon: Icon(Icons.assignment_turned_in_outlined))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          tooltip: 'add',
          onPressed: () => {},
        ),
        body: TabBarView(
          children: <Widget>[
            Appointment(),
            MyContacts(),
            Notes(),
            MyTasks(),
          ],
        ),
      ),
    ),debugShowCheckedModeBanner:false,
    );
  }
}