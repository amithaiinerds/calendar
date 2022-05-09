
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ViewList extends StatelessWidget 
{
  final list;
  ViewList(this.list);

  var data;

  @override
  Widget build(BuildContext context) 
  {
    data = this.list;
    
    return Scaffold(
        appBar: AppBar(title: Text("List View"),),
        body: ListView.builder
        (
          
          padding: EdgeInsets.all(5),
          itemCount: this.list.length,
          itemBuilder: (BuildContext context, int index)        
          {
            return Container
            (
              margin: EdgeInsets.only(bottom: 5),
              child: ListTile
              (
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                contentPadding: EdgeInsets.all(10),
                tileColor: Colors.purple,
                title: Text(this.list[index]["subject"], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
                subtitle: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text("Start Date: " +  this.list[index]["startDate"].toString().toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 5),
                    Text("End Time: " + this.list[index]["endDate"].toString().toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                  ],
                ),
              )
            );
          }
        ),
    );
  }
}