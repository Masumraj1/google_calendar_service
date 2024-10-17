import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle; // assets থেকে লোড করার জন্য

class GoogleCalendarService {

  final String _calendarId = 'primary';

  // সার্ভিস অ্যাকাউন্ট কী JSON ফাইল অ্যাসেট থেকে লোড করা
  Future<String> _loadServiceAccountKey() async {
    return await rootBundle.loadString('assets/the-cultural-ninja-438905-faaf878b7f8a.json');
  }

  // প্রমাণীকৃত ক্লায়েন্ট তৈরি করা
  Future<AutoRefreshingAuthClient> _getAuthClient() async {
    // JSON ফাইল থেকে সার্ভিস অ্যাকাউন্ট কী লোড করা
    final String serviceAccountKeyJson = await _loadServiceAccountKey();

    // JSON থেকে মানচিত্র তৈরি করা
    final Map<String, dynamic> serviceAccountKey = json.decode(serviceAccountKeyJson);

    // সার্ভিস অ্যাকাউন্ট প্রমাণপত্র
    final accountCredentials = ServiceAccountCredentials.fromJson(serviceAccountKey);

    // API স্কোপ নির্ধারণ করা
    const _scopes = [CalendarApi.calendarScope];

    // প্রমাণীকৃত ক্লায়েন্ট তৈরি করা
    return await clientViaServiceAccount(accountCredentials, _scopes);
  }

  // ========================Create Event Method ===================
  Future<void> createEvent(Event event) async {
    final authClient = await _getAuthClient();
    final calendarApi = CalendarApi(authClient);

    try {
      final createdEvent = await calendarApi.events.insert(event, _calendarId);
      print('Even Created::::===================== ${createdEvent.summary}');
      print('Event Id :::===================== ${createdEvent.id}');
    } catch (e) {
      print('ইভেন্ট তৈরি করার সময় সমস্যা হয়েছে: $e');
    } finally {
      authClient.close();
    }
  }


  // ক্যালেন্ডারের ইভেন্টগুলো রিট্রিভ করা
  Future<List<Event>> getEvents() async {
    final authClient = await _getAuthClient();
    final calendarApi = CalendarApi(authClient);

    try {
      final events = await calendarApi.events.list(_calendarId);
      return events.items ?? [];
    } finally {
      authClient.close();
    }
  }
}
