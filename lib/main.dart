import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'google_calendar_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('ইভেন্ট তৈরি করুন'),
                onPressed: () async {
                  final calendarService = GoogleCalendarService();

                  // নতুন ইভেন্ট তৈরি করা
                  final newEvent = Event(
                    summary: '==============This Even Created By mobile App===============',
                    description: 'এটি একটি টেস্ট ইভেন্ট',
                    start: EventDateTime(
                      dateTime: DateTime.now(),
                      timeZone: 'Asia/Dhaka', // আপনার টাইমজোন দিন
                    ),
                    end: EventDateTime(
                      dateTime: DateTime.now().add(Duration(hours: 1)),
                      timeZone: 'Asia/Dhaka',
                    ),
                  );


                  await calendarService.createEvent(newEvent);
                  print('=================Event Successfully Created=====================');
                },
              ),
              ElevatedButton(
                child: Text('ইভেন্ট দেখুন'),
                onPressed: () async {
                  final calendarService = GoogleCalendarService();

                  // ইভেন্ট রিট্রিভ করা
                  final events = await calendarService.getEvents();
                  for (var event in events) {
                    print('Get: ${event.summary}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
