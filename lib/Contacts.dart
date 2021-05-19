import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class MyContacts extends StatefulWidget {
  @override
  _MyContactsState createState() => _MyContactsState();
}
class _MyContactsState extends State<MyContacts> {

  Future<List<User>> _getUsers() async {

    var data = await http.get(Uri.parse('https://mocki.io/v1/f5089a77-5cbc-4882-975f-46abc21b8aa9'));
    var jsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u["id"], u["fname"],u["lname"],u["image"], u["phone"]);

      users.add(user);

    }

    print(users.length);

    return users;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundImage:NetworkImage(snapshot.data[index].image)),
                    title: Text(snapshot.data[index].fname +" "+ snapshot.data[index].lname),
                    subtitle: Text(snapshot.data[index].phone),

                  );
                },
              );
            }
          },
        ),
      ),



    );
  }
}
class User {
  final int id;
  final String fname;
  final String lname;
  final String phone;
  var image;


  User(this.id, this.fname,this.lname,this.image,this.phone);

}

