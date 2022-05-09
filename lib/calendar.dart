
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_calendar/calendar_client.dart';
import 'package:googleapis/testing/v1.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDemo extends StatefulWidget 
{
  const CalendarDemo({ Key? key }) : super(key: key);

  @override
  State<CalendarDemo> createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> {

      List <Appointment> meetings = <Appointment>[];
	  List details = [];
 
  var new_event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
		  title: Text("Event Calendar"),
        actions: 
		[
			IconButton(onPressed: ()
			{
				body(context);
			}, 
			icon: Icon(Icons.add)),
			IconButton(onPressed: ()
			{
				print(details.length);
				Navigator.push(context, MaterialPageRoute(builder: (context) => ViewList(details)));
			}, 
			icon: Icon(Icons.list))
		],
      ),
        body: SfCalendar
        (
			monthViewSettings: MonthViewSettings(showAgenda: false),
          dataSource: new_event,
          view: CalendarView.week,
          firstDayOfWeek: 1,
		    onTap: calendarTapped,
          // initialDisplayDate: DateTime.now(),
          // initialSelectedDate: DateTime.now(),
        ),
    );
  }

   
void calendarTapped(CalendarTapDetails calendarTapDetails) {
  if (calendarTapDetails.targetElement == CalendarElement.appointment) {
    _showDialog(calendarTapDetails);
  }
}
 
_showDialog(CalendarTapDetails details) async {
  Appointment appointment = details.appointments![0];
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Container(
          child: Text("Appointment Details"),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        content: Text("Subject: " +
            appointment.subject +
            "\nId: " +
            appointment.id.toString() +
            "\nRecurrenceId: " +
            appointment.recurrenceId.toString()+ "\nAppointment type: "+appointment.appointmentType.toString()),
        actions: <Widget>[
           TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );
    },
  );
}

  List<Appointment> getAppointments(startTime, endTime, subject)
  {
    // final DateTime today = DateTime.now();
    // final startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    // final endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Appointment
    (
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      color: Colors.blue
    ));

	setState(() 
	{
		final DateFormat formatter = DateFormat('MM-dd-yyy H:m');
  		final String start = formatter.format(startTime);
  		final String end = formatter.format(endTime);
		// for(int i = 0; i < meetings.length; i++)
		// {
			details.add
			(
				{
					"startDate": start.toString(),
					"endDate": end.toString(),
					"subject": subject
				}
			);
		// }
	});
    print(details[0]);

    return meetings;
  }

	body(context) 
  	{
		  var s = "";
		  var e = "";
  		TextEditingController _eventName = TextEditingController();
		DateTime startTime = DateTime.now();
		DateTime endTime = DateTime.now();
		AlertDialog alert = AlertDialog
    	(
			content: StatefulBuilder(
			builder: (context, setState) 
			{
				return  Column
				(
					mainAxisAlignment: MainAxisAlignment.center,
					mainAxisSize: MainAxisSize.min,
					children: <Widget>
					[
						Row
						(
							// mainAxisSize: MainAxisSize.min,
							children: <Widget>
							[
								FlatButton
								(
									onPressed: () 
									{
										DatePicker.showDateTimePicker(context,
										showTitleActions: true,
										minTime: DateTime(2019, 3, 5),
										maxTime: DateTime(2200, 6, 7), onChanged: (date) 
										{
											print('change $date');
										}, onConfirm: (date) 
										{
											setState(() 
											{
												startTime = date;
												var temp = date.toString().split(" ")[1].toString();		
												 s = temp.toString().split(".")[0].toString();
												print(startTime.toString());
											});
										}, currentTime: DateTime.now(), locale: LocaleType.en);
									},
									child: Text
									(
										'Event Start Time',
										style: TextStyle(color: Colors.blue),
									)),
									Text(s.toString()),
							],
						),
						Row
						(
							children: <Widget>
							[
								FlatButton
								(
									onPressed: () 
									{
										DatePicker.showDateTimePicker
										(
											context,
											showTitleActions: true,
											minTime: DateTime(2019, 3, 5),
											maxTime: DateTime(2200, 6, 7), onChanged: (date) 
											{
												print('change $date');
											}, 
											onConfirm: (date) 
											{
												setState(() 
												{
													endTime = date;
													var temp = date.toString().split(" ")[1].toString();		
												 	e = temp.toString().split(".")[0].toString();
												});
											}, 
											currentTime: DateTime.now(), locale: LocaleType.en);
									},
									child: Text
									(
										'Event End Time',
										style: TextStyle(color: Colors.blue),
									)
								),
								Text(e.toString()),
							],
						),
						Padding
						(
							padding: const EdgeInsets.all(12.0),
							child: TextField(
							controller: _eventName,
							decoration: InputDecoration(hintText: 'Enter Event name'),
							),
						),
						RaisedButton
						(
							child: Text
							(
								'Insert Event',
							),
							color: Colors.grey,
							onPressed: () 
							{
								// setState(() 
								// {
									new_event = MeetingDataSource(getAppointments(startTime, endTime, _eventName.text));
									// Navigator.pop(context);
								// });
							}
						),
					],
				);
			})
		);
		showDialog
		(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context)
			{
				return alert;
			}
		);
  }
}

class MeetingDataSource extends CalendarDataSource
{
  MeetingDataSource(List<Appointment> source)
  {
    appointments = source;
  }
}