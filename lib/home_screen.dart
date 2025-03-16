import 'package:appademics/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'calendar_screen.dart'; // Import for CalendarScreen
import 'qr_code_screen.dart'; // Import for QRCodeScreen
import 'profile_screen.dart'; // Import for ProfileScreen
import 'task_manager.dart'; // Import for TaskPage
import 'noti_service.dart'; // Import for NotiService

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

 final NotiService _notiService = NotiService(); // Instance of NotiService

  @override
  void initState() {
    super.initState();
    _initializeNotifications(); // Initialize notifications when screen is loaded
  }

  //  Initialize the notification service
  Future<void> _initializeNotifications() async {
    await _notiService.initNotification();
 }

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
          
          // Send Notification Button
          Positioned(
            top: 50, // Position it above the center
            left: 0, 
            right: 0,
            child: Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    NotiService().showNotification(
                      title: "Title",
                      body: "Body",
                    );
                  }, 
                  child: const Text("Send Notification"),
                ),
              ),
            ),
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

 //  final NotiService _notiService = NotiService(); // Instance of NotiService

 // @override
 // void initState() {
 //   super.initState();
 //   _initializeNotifications(); // Initialize notifications when screen is loaded
//  }

  // Initialize the notification service
//  Future<void> _initializeNotifications() async {
//    await _notiService.initNotification();
// }

