import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle; // assets থেকে লোড করার জন্য

class GoogleCalendarService {
  final String _calendarId = 'primary';

  // অ্যাসেট থেকে সার্ভিস অ্যাকাউন্ট কী JSON লোড করা
  Future<String> _loadServiceAccountKey() async {
    return await rootBundle.loadString('assets/the-cultural-ninja-438905-faaf878b7f8a.json');
  }

  // একটি প্রমাণীকৃত ক্লায়েন্ট তৈরি করুন
  Future<AutoRefreshingAuthClient> _getAuthClient() async {
    // সার্ভিস অ্যাকাউন্ট JSON লোড করা
    final String serviceAccountKeyJson = await _loadServiceAccountKey();

    // JSON স্ট্রিং থেকে মানচিত্রে রূপান্তর
    final Map<String, dynamic> serviceAccountKey = json.decode(serviceAccountKeyJson);

    // সার্ভিস অ্যাকাউন্টের জন্য প্রমাণপত্র তৈরি করা
    final accountCredentials = ServiceAccountCredentials.fromJson(serviceAccountKey);

    // Calendar API স্কোপ সংজ্ঞায়িত করা
    const _scopes = [CalendarApi.calendarScope];

    // প্রমাণীকৃত ক্লায়েন্ট তৈরি করা
    return await clientViaServiceAccount(accountCredentials, _scopes);
  }

  // প্রধান ক্যালেন্ডারে একটি নতুন ইভেন্ট তৈরি করা
  Future<void> createEvent(Event event) async {
    final authClient = await _getAuthClient();
    final calendarApi = CalendarApi(authClient);

    try {
      await calendarApi.events.insert(event, _calendarId);
    } finally {
      authClient.close();
    }
  }
}
