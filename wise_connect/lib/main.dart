import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'specialist.dart';
import 'specialist_profile_screen.dart';
import 'messages_screen.dart';
import 'service_specialists_screen.dart'; // Import the new screen


void main() {
  runApp(MyApp());
  WakelockPlus.enable();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // Using Google Fonts
      ),
      home: HomeScreen(),
    );
  }
}
final GlobalKey<_HomeScreenState> homeScreenKey = GlobalKey<_HomeScreenState>();

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: homeScreenKey);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    MessagesScreen(),
    SearchScreen(),
    AppointmentsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   void navigateToMessagesWithContact(Specialist specialist) {
    setState(() {
      _selectedIndex = 0; // Switch to the Messages tab
    });

    (_widgetOptions[0] as MessagesScreen).addNewContact(specialist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Customize as needed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointments',
          ),
        ],
      ),
    );
  }
}

// Function to normalize DateTime to midnight
DateTime normalizeDate(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}


// Placeholder for Appointments Screen
class AppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Colors.blue, // Customize as needed
      ),
      body: Center(
        child: Text(
          'Appointments Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => SearchContent(),
        );
      },
    );
  }
}

// The original HomeScreen content moved to SearchScreen
class SearchContent extends StatelessWidget {
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
                    specialist: Specialist(
                      name: 'Alexa Brown',
                      specialization: 'Lashes & Brows',
                      industry: 'Beauty Salon',
                      distance: '1.27km',
                      workingHours: '10:00 AM - 22:00 PM',
                      imageUrl: 'assets/images/alexabrown.jpg',
                      bio: 'Passionate about helping businesses grow online.',
                      rating: 4.5,
                      contentUrls: [
                        'assets/content/hairpost.jpg',
                        'assets/content/hairpost2.jpg',
                      ],
                      schedule: {
                        // Today's date normalized to midnight
                        normalizeDate(DateTime.now()): [
                          TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
                          TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: true),
                          TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: false),
                        ],
                        // Tomorrow's date normalized to midnight
                        normalizeDate(DateTime.now().add(Duration(days: 1))): [
                          TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
                          TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: false),
                          TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: true),
                        ],
                      },
                    ),
                  ),
                  SpecialistCard(
                    specialist: Specialist(
                      name: 'Jonathan Wayne',
                      specialization: 'Tattoo',
                      industry: 'Tattoo Art',
                      distance: '2.7km',
                      workingHours: '10:00 AM - 22:00 PM',
                      imageUrl: 'assets/images/jonathanwayne.jpg',
                      bio: 'Passionate about helping businesses grow online.',
                      contentUrls: [
                        'assets/content/tattoopost.jpg',
                        'assets/content/tattoopost2.jpg',
                      ],
                      rating: 4.5,
                      schedule: {
                        // Today's date normalized to midnight
                        normalizeDate(DateTime.now()): [
                          TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
                          TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: true),
                          TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: false),
                        ],
                        // Tomorrow's date normalized to midnight
                        normalizeDate(DateTime.now().add(Duration(days: 1))): [
                          TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
                          TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: false),
                          TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: true),
                        ],
                      },
                    ),
                  ),
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
  final Specialist specialist;

  SpecialistCard({required this.specialist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SpecialistProfileScreen(specialist: specialist),
          ),
        );
      },
      child: Container(
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
                      backgroundImage: AssetImage(specialist.imageUrl),
                      radius: 40,
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          specialist.distance,
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
                        specialist.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(specialist.specialization),
                      Text(
                        specialist.industry,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      Text(
                        specialist.workingHours,
                        style: TextStyle(color: Colors.green, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Specialist> allSpecialists = [
  Specialist(
    name: 'Alexa Brown',
    specialization: 'Haircut',
    industry: 'Beauty Salon',
    distance: '1.27km',
    workingHours: '10:00 AM - 22:00 PM',
    imageUrl: 'assets/images/alexabrown.jpg',
    bio: 'Passionate about helping businesses grow online.',
    rating: 4.5,
    contentUrls: ['assets/content/hairpost.jpg', 'assets/content/hairpost2.jpg'],
    schedule: {
      normalizeDate(DateTime.now()): [
        TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
        TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: true),
        TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: false),
      ],
      normalizeDate(DateTime.now().add(Duration(days: 1))): [
        TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
        TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: false),
        TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: true),
      ],
    },
  ),
  Specialist(
    name: 'Jonathan Wayne',
    specialization: 'Tattoo',
    industry: 'Tattoo Art',
    distance: '2.7km',
    workingHours: '10:00 AM - 22:00 PM',
    imageUrl: 'assets/images/jonathanwayne.jpg',
    bio: 'Passionate about helping businesses grow online.',
    contentUrls: ['assets/content/tattoopost.jpg', 'assets/content/tattoopost2.jpg'],
    rating: 4.5,
    schedule: {
      normalizeDate(DateTime.now()): [
        TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
        TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: true),
        TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: false),
      ],
      normalizeDate(DateTime.now().add(Duration(days: 1))): [
        TimeSlot(time: TimeOfDay(hour: 9, minute: 0), isBooked: false),
        TimeSlot(time: TimeOfDay(hour: 10, minute: 0), isBooked: false),
        TimeSlot(time: TimeOfDay(hour: 11, minute: 0), isBooked: true),
      ],
    },
  ),
  // Add more specialists as needed
];

class ServiceIcon extends StatelessWidget {
  final String label;
  final String iconPath;

  ServiceIcon({required this.label, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: InkWell(
        onTap: () {
          // Filter specialists by the selected service label
          List<Specialist> filteredSpecialists = allSpecialists
              .where((specialist) => specialist.specialization.toLowerCase() == label.toLowerCase())
              .toList();

          // Navigate to the ServiceSpecialistsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceSpecialistsScreen(
                serviceName: label,
                specialists: filteredSpecialists,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  iconPath,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
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
      ),
    );
  }
}