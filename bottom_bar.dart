import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex=3;
  static final List<Widget>_widgetOptions =<Widget>[
    const Text("Home"),
    const Text("Search"),
    const Text("Tickets"),
    const Text("Profile"),
  ];

  void _onItemTapped(int index){
        _selectedIndex=index;
        print('Tapped index is ${_selectedIndex}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My tickets"),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.grey, // Set the selected item color to grey
        unselectedItemColor: const Color(0xFF526488), // Set the unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_search_filled),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_accounts_filled),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_person_accounts_filled),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
