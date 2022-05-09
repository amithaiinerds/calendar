// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:google_calendar/calendar.dart';

void main() => runApp(Google_calendar_events());

class Google_calendar_events extends StatelessWidget 
{
  	@override
  	Widget build(BuildContext context) 
	{
    	return MaterialApp
		(
      debugShowCheckedModeBanner: false,
			title: 'Event Calendar',
			home: CalendarDemo(),
    	);
  	}
}

