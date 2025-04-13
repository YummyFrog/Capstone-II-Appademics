import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isTutor; // Added parameter to distinguish user type
  
  const SettingsScreen({super.key, this.isTutor = false}); // Default to student

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifications = false;
  bool _pushNotifications = false;
  String _privacySetting = 'Public';
  String _selectedLanguage = 'English';
  String _name = '';
  String _email = '';
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isTutor ? 'Tutor Settings' : 'Student Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // User-type specific settings section
          ExpansionTile(
            title: Text(widget.isTutor ? 'Tutor Tools' : 'Student Tools'),
            children: [
              if (widget.isTutor) ...[
                ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('Manage Students'),
                  onTap: () => _showFeatureNotAvailable(context),
                ),
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: const Text('Class Management'),
                  onTap: () => _showFeatureNotAvailable(context),
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('Assignment Creator'),
                  onTap: () => _showFeatureNotAvailable(context),
                ),
              ] else ...[
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('My Courses'),
                  onTap: () => _showFeatureNotAvailable(context),
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_turned_in),
                  title: const Text('My Assignments'),
                  onTap: () => _showFeatureNotAvailable(context),
                ),
              ],
            ],
          ),

          // Common settings sections
          ExpansionTile(
            title: const Text('Account Settings'),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile Management'),
                onTap: _showProfileManagementDialog,
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Password Management'),
                onTap: _showPasswordManagementDialog,
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Notification Settings'),
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.email),
                title: const Text('Email Notifications'),
                value: _emailNotifications,
                onChanged: (val) => setState(() => _emailNotifications = val),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.notifications),
                title: const Text('Push Notifications'),
                value: _pushNotifications,
                onChanged: (val) => setState(() => _pushNotifications = val),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Privacy Settings'),
            children: [
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Data Privacy'),
                onTap: _showPrivacySettingsDialog,
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Language & Accessibility'),
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language Preferences'),
                onTap: _showLanguageSettingsDialog,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.isTutor ? 'Tutor' : 'Student'} settings saved')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save Changes', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  // Helper method to show feature placeholder
  void _showFeatureNotAvailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.isTutor ? 'Tutor' : 'Student'} feature coming soon!')),
    );
  }

  // Rest of your existing dialog methods remain exactly the same
  void _showProfileManagementDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Profile Management'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => setState(() => _name = val),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (val) => setState(() => _email = val),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showPasswordManagementDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Password Management'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Current Password'),
                onChanged: (val) => setState(() => _currentPassword = val),
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
                onChanged: (val) => setState(() => _newPassword = val),
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                onChanged: (val) => setState(() => _confirmPassword = val),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (_newPassword == _confirmPassword) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password changed successfully!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Passwords do not match')),
                );
              }
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettingsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Privacy Settings'),
        content: DropdownButton<String>(
          value: _privacySetting,
          isExpanded: true,
          items: ['Public', 'Friends Only', 'Private']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => setState(() => _privacySetting = val!),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
        ],
      ),
    );
  }

  void _showLanguageSettingsDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Language Preferences'),
        content: DropdownButton<String>(
          value: _selectedLanguage,
          isExpanded: true,
          items: ['English', 'Spanish', 'French']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => setState(() => _selectedLanguage = val!),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
        ],
      ),
    );
  }
}