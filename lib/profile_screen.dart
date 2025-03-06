import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://example.com/profile_picture.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'john.doe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'A short bio about John Doe. This can be a few sentences long and provide some background information.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildListTile(context, 'Personal Information', PersonalInfoScreen()),
                  _buildListTile(context, 'Qualifications', QualificationsScreen()),
                  _buildListTile(context, 'Tutoring Availability', AvailabilityScreen()),
                  _buildListTile(context, 'Average Rating', RatingScreen()),
                  _buildListTile(context, 'Session History', SessionHistoryScreen()),
                  _buildListTile(context, 'Payment Information', PaymentInfoScreen()),
                  _buildListTile(context, 'Settings', SettingsScreen()),
                  _buildListTile(context, 'Logout', null), // No navigation for logout
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, Widget? screen) {
    return ListTile(
      title: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[200], // Light orange color
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        onPressed: () {
          if (screen != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
          } else {
            // Handle logout functionality here
          }
        },
      ),
    );
  }
}

// Placeholder screens for navigation
class PersonalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Personal Info Screen')));
  }
}

class QualificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Qualifications Screen')));
  }
}

class AvailabilityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Availability Screen')));
  }
}

class RatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Rating Screen')));
  }
}

class SessionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Session History Screen')));
  }
}

class PaymentInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Payment Info Screen')));
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Settings Screen')));
  }
}

// Home Screen with Menu
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (value) {
              switch (value) {
                case 'home':
                  // Navigate to Home (already on Home)
                  break;
                case 'subjects':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectsScreen()));
                  break;
                case 'tutors':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TutorsScreen()));
                  break;
                case 'scheduling':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SchedulingScreen()));
                  break;
                case 'resources':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResourcesScreen()));
                  break;
                case 'pricing':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PricingScreen()));
                  break;
                case 'faq':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FAQScreen()));
                  break;
                case 'contact':
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen()));
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'home',
                child: Text('Home'),
              ),
              const PopupMenuItem<String>(
                value: 'subjects',
                child: Text('Subjects Offered'),
              ),
              const PopupMenuItem<String>(
                value: 'tutors',
                child: Text('Tutors'),
              ),
              const PopupMenuItem<String>(
                value: 'scheduling',
                child: Text('Scheduling'),
              ),
              const PopupMenuItem<String>(
                value: 'resources',
                child: Text('Resources'),
              ),
              const PopupMenuItem<String>(
                value: 'pricing',
                child: Text('Pricing'),
              ),
              const PopupMenuItem<String>(
                value: 'faq',
                child: Text('FAQ'),
              ),
              const PopupMenuItem<String>(
                value: 'contact',
                child: Text('Contact Us'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                // Handle search logic here
                print("Searching for: $value");
              },
            ),
            const SizedBox(height: 20),
            // Content Area (Add more widgets here as needed)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                child: const Text('Go to Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens for new navigation options
class SubjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Subjects Offered')));
  }
}

class TutorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Tutors')));
  }
}

class SchedulingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Scheduling')));
  }
}

class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Resources')));
  }
}

class PricingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Pricing')));
  }
}

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('FAQ')));
  }
}

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Contact Us')));
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
