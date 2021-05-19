import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

  }
  @override
  void dispose() {

    _calendarController.dispose();
    super.dispose();
  }
  Future<List<Event>> _getEvents() async {

    var data = await http.get(Uri.parse('https://mocki.io/v1/7ab0a2a1-4a0f-41a6-899b-33038e531bef'));
    var jsonData = json.decode(data.body);

    List<Event> events = [];

    for(var e in jsonData){

      Event event = Event(e["id"], e["eventName"],e["eventDescription"]);

      events.add(event);

    }

    print(events.length);

    return events;

  }
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      headerStyle: HeaderStyle(centerHeaderTitle: true),
      onDaySelected: (date,events, _){
        var datetime = new DateFormat.yMMMMd('en_US').format(date);
        setState(() {
             showModalBottomSheet(context: context, builder:( builder){
               return Container(
                     child: FutureBuilder(
                         future: _getEvents(),
                         builder: ( context,snapshot) {
                           if (snapshot.data == null) {
                             return Container(
                                 child: Center(
                                     child: Text("Loading...")
                                 )
                             );
                           } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child:Center(
                                        child: Text(datetime.toString(),style:TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),),
                                  )),
                                  Expanded(
                                      child: SizedBox
                                        (height: 200.0,
                                         child:ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context, int index) {
                                           return Card(child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.stretch,
                                             children: [ListTile(
                                                title: Text(snapshot.data[index].eventName),
                                                subtitle: Text(snapshot.data[index].eventDescription),

                                           )],
                                           ),color: Colors.grey);

                                        }
                                        )
                                    ,)
                                  )

                                ],),
                            );

                           }
                         }),
               );
             });
        });
      },
    );
  }
}
class Event {
  final int id;
  final String eventName;
  final String eventDescription;


  Event(this.id,this.eventName,this.eventDescription);

}
