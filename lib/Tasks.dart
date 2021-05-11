import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  bool firstvalue = false;
  Future<List<Task>> _getTasks() async {

    var data =  await rootBundle.loadString('assets/TaskResponse.json');
    var jsonData = json.decode(data);

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

