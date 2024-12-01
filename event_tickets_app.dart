import 'package:flutter/material.dart';
import 'event_tickets_home_page.dart';

class EventTicketsApp extends StatelessWidget {
  const EventTicketsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperLeague Tickets',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: EventTicketsHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
