import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:intl/number_symbols.dart';
class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Future<List<Note>> _getNotes() async {

    var data = await rootBundle.loadString('assets/NoteResponse.json');
    var jsonData = json.decode(data);

    List<Note> notes = [];

    for(var u in jsonData){

      Note note = Note(u["id"], u["noteTitle"], u["noteSubtitle"]);

      notes.add(note);

    }

    print(notes.length);

    return notes;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
         child:FutureBuilder(
           future: _getNotes(),
           builder: ( context,snapshot){
            if (snapshot.data == null){
              return Container(
                margin: EdgeInsets.all(30.0),
                  child: Center(
                    child: Text("Loading...")
                  )
                  );
            }else{
                return Container(
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    children:[
                      Card(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text(snapshot.data[0].noteTitle),
                          subtitle: Text(snapshot.data[0].noteSubtitle),
                        )
                      ],),color: Colors.yellow,shadowColor: Colors.grey,elevation: 15.0,),
                      Card(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text(snapshot.data[1].noteTitle),
                            subtitle: Text(snapshot.data[1].noteSubtitle),
                          )
                        ],),color: Colors.white,shadowColor: Colors.grey,elevation: 15.0,),
                      Card(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text(snapshot.data[2].noteTitle),
                            subtitle: Text(snapshot.data[2].noteSubtitle),
                          )
                        ],),color: Colors.red,shadowColor: Colors.grey,elevation: 15.0,)
                    ],
                  ),
                );


               }
        }),
       ));
  }
}
class Note {
  final int id;
  final String noteTitle;
  final String noteSubtitle;
  Note(this.id,this.noteTitle,this.noteSubtitle);

}
