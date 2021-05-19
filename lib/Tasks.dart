import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  Future<List<Task>> _getTasks() async {

    var data = await http.get(Uri.parse('https://mocki.io/v1/aa063fe9-80b8-4717-968e-960b4871e3bd'));
    var jsonData = json.decode(data.body);

    List<Task> tasks = [];

    for(var T in jsonData){

      Task task = Task(T["id"], T["name"], T["taskDate"],T["completed"]);

      tasks.add(task);

    }

    print(tasks.length);

    return tasks;

  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Container(
            padding: new EdgeInsets.all(22.0),
            child: FutureBuilder(
                future: (_getTasks()),
                builder: ( context,snapshot){
              if (snapshot.hasError){
                return Container(child: Center(
                 child: Text("Loading...")
            ));}
              else{
                return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data==null?0: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].taskDate ?? ''),
                          value: snapshot.data[index].completed,
                          onChanged: (bool value) {
                            setState(() {
                              snapshot.data[index].completed = value;
                            });
                          },);
                      })
                );
                }})
           ),
        );


  }
}
class Task {
  final int id;
  final String name;
  final String taskDate;
  final bool completed ;

  Task(this.id, this.name,this.taskDate,this.completed);

}

