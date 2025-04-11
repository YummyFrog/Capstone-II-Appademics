import 'package:flutter/material.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
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
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: const Text('Account Settings'),
            children: [
              ListTile(
                title: const Text('Profile Management'),
                onTap: _showProfileManagementDialog,
              ),
              ListTile(
                title: const Text('Password Management'),
                onTap: _showPasswordManagementDialog,
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Notification Settings'),
            children: [
              SwitchListTile(
                title: const Text('Email Notifications'),
                value: _emailNotifications,
                onChanged: (val) => setState(() => _emailNotifications = val),
              ),
              SwitchListTile(
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
                title: const Text('Data Privacy'),
                onTap: _showPrivacySettingsDialog,
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('Language & Accessibility'),
            children: [
              ListTile(
                title: const Text('Language Preferences'),
                onTap: _showLanguageSettingsDialog,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle save action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings Saved')),
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

  void _showProfileManagementDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Profile Management'),
        content: Column(
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
        content: Column(
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
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully!')),
              );
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
