import 'package:flutter/material.dart';
import 'package:frontend/screens/historyScreen.dart';
import 'package:frontend/screens/homeScreen.dart';
import 'package:frontend/screens/profileScreen.dart';
import 'package:frontend/screens/searchScreen.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: DrawerHeaderChild(),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.black),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.black),
              title: Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.black),
              title: Text(
                'Notifications',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("E-Shop"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Hamburger icon
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        centerTitle: true, // Ensures title is centered in the AppBar
      ),
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: _screens,
      // ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black, // Set selected icon color to black
        unselectedItemColor: Colors.black, // Set unselected icon color to black
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


class DrawerHeaderChild extends StatelessWidget {
  const DrawerHeaderChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            print("Icon tapped");
          },
          child: Container(
            padding: const EdgeInsets.all(4.0), // Space between image and border
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue, // Border color
                width: 2.0, // Border width
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/icons/google.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text("Ayush2422005@gmail.com"),
        ),
        const Text("Ayush2422005@gmail.com"),
      ],
    );
  }
}
