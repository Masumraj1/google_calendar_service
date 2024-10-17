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
        appBar: AppBar(
          title: Text('Google Calendar ইভেন্ট তৈরি করুন'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('ইভেন্ট তৈরি করুন'),
            onPressed: () async {
              final calendarService = GoogleCalendarService();

              // একটি নতুন ইভেন্ট তৈরি করা
              final newEvent = Event(
                summary: 'নতুন ইভেন্ট',
                description: 'এই ইভেন্টটি অ্যাপ থেকে তৈরি করা হয়েছে',
                start: EventDateTime(dateTime: DateTime.now()),
                end: EventDateTime(dateTime: DateTime.now().add(const Duration(hours: 1))),
              );

              await calendarService.createEvent(newEvent);

              print('ইভেন্ট সফলভাবে তৈরি করা হয়েছে এবং এটি Google Calendar-এ প্রদর্শিত হবে');
            },
          ),
        ),
      ),
    );
  }
}
