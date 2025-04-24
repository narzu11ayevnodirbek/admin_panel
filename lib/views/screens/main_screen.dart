import 'package:admin_panel/views/screens/hotels/manage_hotels_screen.dart';
import 'package:admin_panel/views/screens/settings_screen.dart';
import 'package:admin_panel/views/screens/users/manage_users_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    ManageHotelsScreen(),
    ManageUsersScreen(),
    SettingsScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Users"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          index = value;
          setState(() {});
        },
      ),
    );
  }
}
