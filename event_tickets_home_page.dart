import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'add_ticket_page.dart';
import 'event_card.dart';
import 'more_details.dart';
import 'ticket_details_page.dart';
import 'login_page.dart'; // Import the login page

class EventTicketsHomePage extends StatefulWidget {
  const EventTicketsHomePage({super.key});

  @override
  _EventTicketsHomePageState createState() => _EventTicketsHomePageState();
}

class _EventTicketsHomePageState extends State<EventTicketsHomePage> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();

  Timer? _timer;
  int _currentPage = 0;
  int _selectedIndex = 0;

  final List<String> imagePaths = [
    'assets/fam.jpeg',
    'assets/fam1.jpeg',
    'assets/fam2.jpeg',
    'assets/fam3.jpeg',
  ];

  List<Map<String, String>> filteredEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startImageRotation();
    _fetchEvents();
  }

  void _startImageRotation() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % imagePaths.length;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  void _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance.collection('tickets').snapshots().listen((snapshot) {
      setState(() {
        filteredEvents = snapshot.docs
            .map((doc) {
          final data = doc.data();
          final eventTime = data['time']; // Firestore Timestamp
          if (eventTime is Timestamp) {
            final eventDate = eventTime.toDate();
            final today = DateTime.now();
            // If the event is today or in the future, include it
            if (eventDate.isAtSameMomentAs(today) || eventDate.isAfter(today)) {
              return {
                'imageUrl': data['imageUrl']?.toString() ?? '',
                'title': data['title']?.toString() ?? '',
                'description': data['description']?.toString() ?? '',
                'venue': data['venue']?.toString() ?? '',
                'time': eventDate.toString(), // Format as needed
              };
            }
          }
          return null;
        })
            .where((event) => event != null)
            .cast<Map<String, String>>()
            .toList();

        // Sort events by the time field (ascending order)
        filteredEvents.sort((a, b) {
          final timeA = DateTime.parse(a['time']!);
          final timeB = DateTime.parse(b['time']!);
          return timeA.compareTo(timeB);
        });

        _isLoading = false;
      });
    });
  }

  void _filterEvents(String query) {
    setState(() {
      if (query.isEmpty) {
        _fetchEvents();
      } else {
        filteredEvents = filteredEvents
            .where((event) =>
            event['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigate to My Tickets Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EventTicketsHomePage()),
      );
    } else if (index == 1) {
      // Navigate to Transfers Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddTicketPage()),
      );
    } else if (index == 2) {
      // Navigate to About Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png', fit: BoxFit.contain, height: 40),
        ),
        title: const Text(
          'SPORTS TICKETS IN MALAWI',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.teal[700],
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (String value) {
              if (value == 'Add Ticket') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTicketPage(),
                  ),
                );
              } else if (value == 'Logout') {
                // Handle Logout (navigate to login page)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                // Handle other menu actions
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Profile', child: Text('Profile')),
              const PopupMenuItem(value: 'Settings', child: Text('Settings')),
              const PopupMenuItem(value: 'Add Ticket', child: Text('Add Ticket')),
              const PopupMenuItem(value: 'Logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 320,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
                Container(
                  height: 320,
                  color: Colors.teal.withOpacity(0.7),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        onChanged: _filterEvents,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search artist, team, or venue',
                          border: InputBorder.none,
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Event Tickets Package',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Event Tickets',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredEvents.isEmpty
                ? const Center(child: Text('No events found'))
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to TicketDetailsPage on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketDetailsPage(
                          eventData: filteredEvents[index],
                        ),
                      ),
                    );
                  },
                  child: EventCard(
                    eventData: filteredEvents[index], // Pass event data
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFEC1C24),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'My tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transfer_within_a_station),
            label: 'Transfers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
