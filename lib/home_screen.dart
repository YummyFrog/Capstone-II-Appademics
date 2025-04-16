import 'package:flutter/material.dart';
import 'package:appademics/calendar_screen.dart';
import 'package:appademics/qr_code_screen.dart';
import 'package:appademics/profile_screen.dart' as profile;  // Added prefix
import 'package:appademics/task_manager_screen.dart';
import 'package:appademics/settings_screen.dart' as app_settings;  // Added prefix
import 'package:appademics/help_support_screen.dart';
import 'package:appademics/grid_view_tutor_profiles.dart'; // Grid view of tutor profiles


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _screens = [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Welcome Tutor',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: GridViewTutorProfiles()),
    ],
  ),


    const CalendarScreen(),
    const QRCodeScreen(),
    const profile.ProfileScreen(), // Updated with prefix
  ];

final List<Widget> _titleWidgets = [
  const Text(
    'Home',
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  const Text(
    'Calendar',
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  const Text(
    'QR Code',
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  const Text(
    'Profile', 
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
  ),
];
 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _openSortDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Sort by"),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text("Alphabet (A-Z)"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text("Alphabet (Z-A)"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text("Newest First"),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: const Text("Oldest First"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomePage = _selectedIndex == 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Changed the color of the app bar
        title: _titleWidgets[_selectedIndex],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (isHomePage)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search subjects...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                      });
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.sort),
                        onPressed: _openSortDialog,
                      ),
                    ],
                  ),
                ),
            
            
            
            ],
          ),
          GestureDetector(
            onTap: () {
              if (_isMenuOpen) {
                setState(() => _isMenuOpen = false);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: _selectedIndex == 0 ? 64.0 : 0.0), // Edited so only the homepage has padding
              child: _screens[_selectedIndex],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isMenuOpen ? MediaQuery.of(context).size.width * 0.5 : 0,
            color: const Color.fromARGB(255, 124, 187, 214),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const app_settings.SettingsScreen(isTutor: true), // Updated with prefix
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.help),
                        title: const Text('Help & Support'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpSupportScreen(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.task),
                        title: const Text('Task Manager'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TaskManagerScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : null,
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}