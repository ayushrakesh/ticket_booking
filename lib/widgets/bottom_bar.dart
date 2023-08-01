import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:ticket_booking/screens/profile_screen.dart';
import 'package:ticket_booking/screens/tickets_screen.dart';

import '../screens/search_screen.dart';
import '../screens/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/nav-bottom';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  static final List<Widget> widgetOptions = [
    HomeScreen(),
    const SearchScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 24,
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.home_24_regular),
              activeIcon: Icon(FluentIcons.home_24_filled),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.search_24_regular),
              activeIcon: Icon(FluentIcons.search_24_filled),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.ticket_diagonal_24_regular),
              activeIcon: Icon(FluentIcons.ticket_diagonal_24_filled),
              label: 'Tickets'),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.person_24_regular),
              activeIcon: Icon(FluentIcons.person_24_filled),
              label: 'Profile'),
        ],
      ),
    );
  }
}
