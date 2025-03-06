import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'qr_code_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isFilterDropdownOpen = false;
  String _searchQuery = '';

  final List<Widget> _screens = [
    const Center(child: Text('Home Screen', style: TextStyle(fontSize: 18))),
    const CalendarScreen(),
    const QRCodeScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFilterDropdown() {
    setState(() {
      _isFilterDropdownOpen = !_isFilterDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appademics'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedIndex == 0) ...[
              const Text(
                'Welcome back, John Doe!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search Sessions',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: _toggleFilterDropdown,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Filter Options Dropdown
              if (_isFilterDropdownOpen) ...[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filter By:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildFilterOption('Subjects'),
                      _buildFilterOption('Tutors'),
                      _buildFilterOption('Time'),
                      _buildFilterOption('Tutor Rating'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Next Session Info
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Next Session',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Date: March 1, 2025',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Time: 10:00 AM - 11:00 AM',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Day: Saturday',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR Code'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildFilterOption(String option) {
    return ListTile(
      title: Text(option),
      onTap: () {
        // Handle filter option selection
        Navigator.pop(context); // Close the filter dropdown
        print('Selected filter: $option'); // Add your filter handling logic here
      },
    );
  }
}
