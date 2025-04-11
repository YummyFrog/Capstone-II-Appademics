import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  void _showFeedbackDialog(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Submit Feedback"),
        content: TextField(
          controller: feedbackController,
          maxLines: 4,
          decoration: const InputDecoration(hintText: "Write your feedback here..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Feedback submitted!")),
              );
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("FAQs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const ListTile(
            title: Text("How do I use the task manager?"),
            subtitle: Text("Navigate to the Task Manager from the menu and tap 'Add' to create tasks."),
          ),
          const ListTile(
            title: Text("Can I edit or delete tasks?"),
            subtitle: Text("Yes, tap the task to edit, or the delete icon to remove it."),
          ),
          const SizedBox(height: 20),
          const Text("Contact Support", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Email"),
            subtitle: const Text("support@appademics.com"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text("Phone"),
            subtitle: const Text("+1 800 123 4567"),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          const Text("Tutorials", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            title: const Text("Using the Calendar"),
            subtitle: const Text("Learn how to add and track events."),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Generating QR Codes"),
            subtitle: const Text("Quick tutorial on QR Code features."),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          const Text("Feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text("Submit Feedback"),
            onTap: () => _showFeedbackDialog(context),
          ),
          const SizedBox(height: 20),
          const Text("Live Chat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text("Chat with Us"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Live chat is currently unavailable.")),
              );
            },
          ),
        ],
      ),
    );
  }
}
