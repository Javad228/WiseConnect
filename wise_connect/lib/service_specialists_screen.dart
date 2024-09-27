// service_specialists_screen.dart

import 'package:flutter/material.dart';
import 'specialist.dart';
import 'specialist_profile_screen.dart';

class ServiceSpecialistsScreen extends StatelessWidget {
  final String serviceName;
  final List<Specialist> specialists;

  ServiceSpecialistsScreen({required this.serviceName, required this.specialists});

  @override
  Widget build(BuildContext context) {
    // Sort specialists by distance
    specialists.sort((a, b) => _parseDistance(a.distance).compareTo(_parseDistance(b.distance)));

    return Scaffold(
      appBar: AppBar(
        title: Text('$serviceName Specialists'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: specialists.length,
        itemBuilder: (context, index) {
          final specialist = specialists[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(specialist.imageUrl),
            ),
            title: Text(specialist.name),
            subtitle: Text('${specialist.specialization} • ${specialist.distance} away'),
            onTap: () {
              // Navigate to the specialist's profile screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpecialistProfileScreen(specialist: specialist),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Helper function to parse distance string to double for sorting
  double _parseDistance(String distance) {
    return double.tryParse(distance.replaceAll('km', '').trim()) ?? double.infinity;
  }
}
