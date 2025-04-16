import 'package:flutter/material.dart';

class StuProfileScreen extends StatelessWidget {
  const StuProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 30),
                      onPressed: () {
                        // Handle profile picture edit
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Student Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text('student@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Computer Science Major | Class of 2024',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Student-specific profile sections
              _buildListTile(context, 'Personal Information', Icons.person, StuPersonalInfoScreen()),
              _buildListTile(context, 'Academic Records', Icons.school, StuAcademicRecordsScreen()),
              _buildListTile(context, 'Class Schedule', Icons.access_time, StuScheduleScreen()),
              _buildListTile(context, 'Assignment Submissions', Icons.assignment, StuAssignmentsScreen()),
              _buildListTile(context, 'Payment History', Icons.payment, StuPaymentsScreen()),
              _buildListTile(context, 'Course Resources', Icons.book, StuResourcesScreen()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle logout logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged Out')),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Logout', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildListTile(BuildContext context, String title, IconData icon, Widget screen) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}

// Student Personal Information Screen
class StuPersonalInfoScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController(text: 'Student Name');
  final TextEditingController studentIdController = TextEditingController(text: 'S12345678');
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Information'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildReadOnlyField('Full Name', fullNameController),
              _buildReadOnlyField('Student ID', studentIdController),
              _buildEditableField('Phone Number', phoneController),
              _buildEditableField('Address', addressController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Information Saved')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}

// Student Academic Records Screen
class StuAcademicRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Academic Records'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Current GPA: 3.75', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Course ${index + 1}'),
                      subtitle: Text('Grade: A-'),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Student Schedule Screen
class StuScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Schedule'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Course ${index + 1}'),
                      subtitle: Text('Mon/Wed 10:00-11:30 AM'),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Student Assignments Screen
class StuAssignmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Submissions'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Assignment ${index + 1}'),
                      subtitle: Text('Due: ${DateTime.now().add(Duration(days: index * 7)).toString().split(' ')[0]}'),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Student Payments Screen
class StuPaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment History'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Outstanding Balance: \$1,250.00', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Payment ${index + 1}'),
                      subtitle: Text('\$500.00 - ${DateTime.now().subtract(Duration(days: index * 30)).toString().split(' ')[0]}'),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Student Resources Screen
class StuResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Resources'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Resource ${index + 1}'),
                      subtitle: const Text('PDF - Course Material'),
                      trailing: const Icon(Icons.download),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}