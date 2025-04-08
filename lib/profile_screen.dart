import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to the Dashboard'),
        backgroundColor: Colors.blue, // Changed to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Changed to blue
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: const Text('Go to Profile', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue, // Changed to blue
      ),
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
                    backgroundImage: NetworkImage('https://example.com/profile_picture.png'),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle profile picture edit
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Text('john.doe@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'A short bio about John Doe. This can be a few sentences long and provide some background information.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildListTile(context, 'Personal Information', Icons.person, PersonalInfoScreen()),
              _buildListTile(context, 'Qualifications', Icons.school, QualificationsScreen()),
              _buildListTile(context, 'Tutoring Availability', Icons.access_time, AvailabilityScreen()),
              _buildListTile(context, 'Student Engagement & Ratings', Icons.star, EngagementScreen()),
              _buildListTile(context, 'Session Management', Icons.schedule, SessionManagementScreen()),
              _buildListTile(context, 'Payments & Earnings', Icons.payment, PaymentsScreen()),
              _buildListTile(context, 'Resources & Course Management', Icons.book, ResourcesScreen()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle logout logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged Out')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Changed to BlueAccent
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
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent), // Changed to blueAccent
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}

// Personal Information Screen
class PersonalInfoScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController(text: 'John Doe');
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Information'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(fullNameController, 'Full Name'),
              _buildTextField(phoneNumberController, 'Phone Number'),
              _buildTextField(cityController, 'City'),
              _buildTextField(stateController, 'State'),
              _buildTextField(countryController, 'Country'),
              _buildPreferredLanguageDropdown(),
              _buildDateOfBirthField(context),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Personal Information Saved')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Changed to BlueAccent
                ),
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Changed to BlueAccent
                ),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
    );
  }

  Widget _buildPreferredLanguageDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Preferred Language', border: OutlineInputBorder()),
      items: const [
        DropdownMenuItem(value: 'EN', child: Text('English')),
        DropdownMenuItem(value: 'SP', child: Text('Spanish')),
        DropdownMenuItem(value: 'FR', child: Text('French')),
      ],
      onChanged: (value) {
        // Handle language selection
      },
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return TextField(
      controller: dobController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
            }
          },
        ),
      ),
    );
  }
}

// Qualifications Screen
class QualificationsScreen extends StatelessWidget {
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController universityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qualifications'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(degreeController, 'Degree'),
            _buildTextField(universityController, 'University'),
            _buildYearDropdown(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Qualifications Saved')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
    );
  }

  Widget _buildYearDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Year of Completion', border: OutlineInputBorder()),
      items: List.generate(50, (index) {
        int year = DateTime.now().year - index;
        return DropdownMenuItem(value: year.toString(), child: Text(year.toString()));
      }),
      onChanged: (value) {
        // Handle year selection
      },
      isExpanded: true,
      dropdownColor: Colors.white,
    );
  }
}

// Tutoring Availability Screen
class AvailabilityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tutoring Availability'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Available Days & Time Slots:', style: TextStyle(fontSize: 18)),
            // Implement checkboxes or toggles for available days
            // Implement time slot selection
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Availability Saved')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Save Availability'),
            ),
          ],
        ),
      ),
    );
  }
}

// Session Management Screen
class SessionManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Management'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Upcoming Sessions:', style: TextStyle(fontSize: 18)),
            Expanded(child: _buildSessionList()),
            ElevatedButton(
              onPressed: () {
                // Handle any additional actions
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Add New Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList() {
    return ListView.builder(
      itemCount: 5, // Placeholder for session count
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Session ${index + 1}'),
            subtitle: Text('Date & Time: 2023-04-01 10:00 AM\nStudent: Student Name'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.cancel), onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Payments Screen
class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments & Earnings'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Keep track of your financial status with clear metrics.', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            _buildTotalEarningsOverview(),
            const SizedBox(height: 20),
            _buildPendingPaymentsTable(),
            const SizedBox(height: 20),
            _buildWithdrawalHistoryTable(),
            const SizedBox(height: 20),
            _buildPaymentMethods(),
            const SizedBox(height: 20),
            _buildPaymentPreferences(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle withdrawal logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Withdraw Funds'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalEarningsOverview() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Earnings Overview:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('\$5000 (Monthly)', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text('\$60000 (Yearly)', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // Placeholder for a graph
            Container(
              height: 200,
              color: Colors.grey[300], // Placeholder color for graph
              child: const Center(child: Text('Graph Placeholder')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingPaymentsTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pending Payments:', style: TextStyle(fontSize: 18)),
            DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Action')),
              ],
              rows: List.generate(3, (index) {
                return DataRow(cells: [
                  DataCell(Text('2023-04-01')),
                  DataCell(Text('\$500')),
                  DataCell(Text('Pending')),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            // Handle approve action
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            // Handle cancel action
                          },
                        ),
                      ],
                    ),
                  ),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawalHistoryTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Withdrawal History:', style: TextStyle(fontSize: 18)),
            DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Status')),
              ],
              rows: List.generate(3, (index) {
                return DataRow(cells: [
                  DataCell(Text('2023-04-01')),
                  DataCell(Text('\$2000')),
                  DataCell(Text('Completed')),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Linked Payment Methods:', style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text('Bank'),
              trailing: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // Handle remove action
                },
              ),
            ),
            ListTile(
              title: const Text('PayPal'),
              trailing: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // Handle remove action
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle add payment method logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Add New Method'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentPreferences() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment Preferences:', style: TextStyle(fontSize: 18)),
            SwitchListTile(
              title: const Text('Auto Withdraw'),
              value: true,
              onChanged: (bool value) {
                // Handle toggle change
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Minimum Payout Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

// Resources Screen
class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources & Course Management'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Uploaded Teaching Materials:', style: TextStyle(fontSize: 18)),
            Expanded(child: _buildResourceList()),
            ElevatedButton(
              onPressed: () {
                // Handle upload logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Upload Resource'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceList() {
    return ListView.builder(
      itemCount: 5, // Placeholder for resource count
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Resource ${index + 1}'),
            subtitle: Text('Type: PDF\nDescription: Resource description goes here.'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Support Screen
class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support & Help Center'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('FAQ Section:', style: TextStyle(fontSize: 18)),
            Expanded(child: _buildFAQList()),
            ElevatedButton(
              onPressed: () {
                // Handle ticket submission
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Submit a Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQList() {
    return ListView.builder(
      itemCount: 5, // Placeholder for FAQ count
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('FAQ Question ${index + 1}'),
            subtitle: Text('Answer to the FAQ goes here.'),
          ),
        );
      },
    );
  }
}

// Engagement Screen
class EngagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Engagement & Ratings'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Overall Tutor Rating:', style: TextStyle(fontSize: 18)),
            const Text('4.5 / 5', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Recent Reviews:', style: TextStyle(fontSize: 18)),
            Expanded(child: _buildReviewList()),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewList() {
    return ListView.builder(
      itemCount: 5, // Placeholder for review count
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Review ${index + 1}'),
            subtitle: Text('This tutor was very helpful!'),
          ),
        );
      },
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings & Customization'), backgroundColor: Colors.blue), // Changed to blue
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Profile Visibility:', style: TextStyle(fontSize: 18)),
            SwitchListTile(
              title: const Text('Public'),
              value: true,
              onChanged: (bool value) {
                // Handle visibility toggle
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings Saved')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Changed to BlueAccent
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

