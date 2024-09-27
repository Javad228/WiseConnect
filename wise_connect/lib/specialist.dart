// lib/specialist.dart

import 'package:flutter/material.dart';

class Specialist {
  final String name;
  final String imageUrl;
  final String specialization;
  final String industry;
  final String distance;
  final String workingHours;
  final String bio;
  final double rating;
  final List<String> contentUrls;

  final Map<DateTime, List<TimeSlot>> schedule;

  Specialist({
    required this.name,
    required this.imageUrl,
    required this.specialization,
    required this.industry,
    required this.distance,
    required this.workingHours,
    required this.bio,
    required this.rating,
    required this.contentUrls,
    required this.schedule,
  });
}

class TimeSlot {
  final TimeOfDay time;
  bool isBooked; // Removed 'final'

  TimeSlot({required this.time, this.isBooked = false});
}
