import 'package:flutter/material.dart';
import 'specialist.dart';
import 'booking_page.dart';
import 'main.dart';

class SpecialistProfileScreen extends StatelessWidget {
  final Specialist specialist;

  SpecialistProfileScreen({required this.specialist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          specialist.name,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        iconTheme: IconThemeData(color: Colors.black), // Back button color
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Picture
            SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: AssetImage(specialist.imageUrl),
              radius: 50,
            ),
            SizedBox(height: 10),
            // Specialist's Name
            Text(
              specialist.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Specialization
            Text(
              specialist.specialization,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            // Icons and Text Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 24, color: Colors.amber),
                SizedBox(width: 4),
                Text(
                  specialist.rating.toStringAsFixed(1),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(Icons.access_time, size: 24, color: Colors.blue),
                SizedBox(width: 4),
                Text(
                  specialist.workingHours,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.location_on, size: 24, color: Colors.red),
                SizedBox(width: 4),
                Text(
                  specialist.distance,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                specialist.bio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton('Contact', () {
                  homeScreenKey.currentState?.navigateToMessagesWithContact(specialist);
                  Navigator.of(context).pop();
                }),
                SizedBox(width: 10),
                _buildActionButton('Book Now', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPage(specialist: specialist),
                    ),
                  );
                }),
                SizedBox(width: 10),
                _buildActionButton('View Prices', () {
                  // Implement view prices functionality
                }),
              ],
            ),
            SizedBox(height: 20),
            // Content Grid
            Divider(thickness: 1),
            _buildContentGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }



  Widget _buildContentGrid() {
    // Placeholder for content grid
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: specialist.contentUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Three columns like TikTok
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Image.asset(
          specialist.contentUrls[index],
          fit: BoxFit.cover,
        );
      },
    );
  }
}
