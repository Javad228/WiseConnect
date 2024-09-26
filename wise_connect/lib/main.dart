import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  runApp(MyApp());
  WakelockPlus.enable();

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // Using Google Fonts
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi User',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Find your specialist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search specialist...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Top Specialists in your Area',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SpecialistCard(
                    name: 'Alexa Brown',
                    specialization: 'Lashes & Brows',
                    industry: 'Beauty Salon',
                    distance: '1.27km',
                    workingHours: '10:00 AM - 22:00 PM',
                    imageUrl: 'assets/images/alexabrown.jpg',
                  ),
                  SpecialistCard(
                    name: 'Jonathan Wayne',
                    specialization: 'Tattoo',
                    industry: 'Tattoo art',
                    distance: '2.7km',
                    workingHours: '10:00 AM - 22:00 PM',
                    imageUrl: 'assets/images/jonathanwayne.jpg',
                  ),
                  // Add more SpecialistCards if needed
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  ServiceIcon(label: 'Haircut', iconPath: 'assets/icons/haircut.jpg'),
                  ServiceIcon(label: 'Bike Repair', iconPath: 'assets/icons/bikerepair.jpg'),
                  ServiceIcon(label: 'Gym', iconPath: 'assets/icons/gym.jpg'),
                  ServiceIcon(label: 'Nails', iconPath: 'assets/icons/nails.jpg'),
                  ServiceIcon(label: 'Makeup', iconPath: 'assets/icons/makeup.jpg'),
                  ServiceIcon(label: 'Plumber', iconPath: 'assets/icons/plumber.jpg'),
                  // Add more services as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialistCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String distance;
  final String workingHours;
  final String imageUrl;
  final String industry;

  SpecialistCard({
    required this.name,
    required this.specialization,
    required this.distance,
    required this.workingHours,
    required this.imageUrl,
    required this.industry
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: EdgeInsets.only(right: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(imageUrl),
                    radius: 40,
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the icon and text horizontally
                    children: [
                      Icon(
                        Icons.location_pin, // Use the location pin icon
                        color: Colors.blue, // Set the icon color to match your design
                        size: 16, // Adjust the size as needed
                      ),
                      SizedBox(width: 4), // Add some spacing between the icon and the text
                      Text(
                        distance,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      specialization,
                    ),
                    Text(
                      industry,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      workingHours,
                      style: TextStyle(color: Colors.green, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final String label;
  final String iconPath;

  ServiceIcon({required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      elevation: 1, // Elevation to give the card a slight shadow
      child: Padding(
        padding: const EdgeInsets.all(0.0), // Add some padding around the icon and label
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                iconPath,
                height: 70,
                width: 70,
                fit: BoxFit.cover, // Ensures the image covers the circular shape
              ),
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 138, 138, 138),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
