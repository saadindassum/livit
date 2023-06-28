// update user state
import 'package:flutter/material.dart';
import 'package:livit/models/event.dart';
import 'package:livit/resources/auth_methods.dart';

class EventProvider with ChangeNotifier {
  List<Event> _availableEvents = [
    Event(
      open: true,
      eid: '42069owl',
      hostID: 'pollos',
      eventName: 'Owl Fest',
      dateTime: DateTime(2023, 4, 20, 4, 20),
      photoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      genreTags: ['rock', 'pop'],
      originals: true,
    ),
  ];

  List<Event> get availableEvents => _availableEvents;

  // Future<void> refreshAvailableEvents() async {
  //   List<Event> avEv = await _authMethods.getUserDetails();
  //   //We'll have to make a method to fetch local details and events rather than user details
  //   _availableEvents = avEv;
  //   notifyListeners();
  // }

  void sortEvents() {
    //TODO: Sort Events by date and then by score
  }

  Event get nextMatchingEvent => _availableEvents[0];

  List<Event> dummyList = [
    Event(
      open: true,
      eid: '42069owl',
      hostID: 'pollos',
      eventName: 'Owl Fest',
      dateTime: DateTime(2023, 4, 20, 4, 20),
      photoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      genreTags: ['rock', 'pop'],
      originals: true,
    ),
  ];
}
