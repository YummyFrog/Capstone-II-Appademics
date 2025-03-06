import 'package:flutter/material.dart';
import 'calendar_screen.dart'; // Import for CalendarScreen
import 'qr_code_screen.dart'; // Import for QRCodeScreen
import 'profile_screen.dart'; // Import for ProfileScreen
import 'task_manager_screen.dart'; // Import for TaskPage

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Tracks the selected index for the bottom navigation bar
  bool _isMenuOpen = false; // Tracks whether the menu is open or closed

  final List<Widget> _screens = [
    const Center(
      child: Text(
        'You logged in!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    const CalendarScreen(),
    const QRCodeScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen; // Toggle the menu state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.menu), // Menu button
          onPressed: _toggleMenu, // Toggle the menu
        ),
      ),
      body: Stack(
        children: [
          // Main content with backdrop tap
          GestureDetector(
            onTap: () {
              if (_isMenuOpen) {
                setState(() {
                  _isMenuOpen = false; // Close the menu
                });
              }
            },
            child: _screens[_selectedIndex], // Display the selected screen
          ),

          // Sliding menu
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Animation duration
            width: _isMenuOpen ? MediaQuery.of(context).size.width * 0.5 : 0, // Halfway open
            color: Colors.blueGrey[100], // Menu background color
            child: _isMenuOpen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Menu',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {
                          // Handle settings tap
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.help),
                        title: const Text('Help'),
                        onTap: () {
                          // Handle help tap
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.task),
                        title: const Text('Task Manager'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TaskPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : null, // Don't render anything when the menu is closed
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple, // Selected item color
        unselectedItemColor: Colors.blue, // Unselected item color
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}