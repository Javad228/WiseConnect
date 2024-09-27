// messages_screen.dart

import 'package:flutter/material.dart';
import 'specialist.dart';
import 'chat_screen.dart'; // Import the ChatScreen

class MessagesScreen extends StatefulWidget {
  final List<Specialist> contacts = []; // List of contacts

  @override
  _MessagesScreenState createState() => _MessagesScreenState();

  // Method to add a new contact
  void addNewContact(Specialist specialist) {
    if (!contacts.any((contact) => contact.name == specialist.name)) {
      contacts.add(specialist);
    }
  }
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        itemCount: widget.contacts.length,
        itemBuilder: (context, index) {
          final contact = widget.contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(contact.imageUrl),
            ),
            title: Text(contact.name),
            subtitle: Text('Last message preview...'), // Placeholder
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(contact: contact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
