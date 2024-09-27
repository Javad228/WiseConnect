import 'package:flutter/material.dart';
import 'specialist.dart';

class BookingPage extends StatefulWidget {
  final Specialist specialist;

  BookingPage({required this.specialist});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeSlot? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    // Get the list of time slots for the selected date
    DateTime normalizedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    List<TimeSlot> timeSlots =
        widget.specialist.schedule[normalizedDate] ?? [];
    Map<DateTime, List<TimeSlot>> lele = widget.specialist.schedule;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.specialist.name}'),
      ),
      body: Column(
        children: [
          // Calendar Widget (Date Picker)
          _buildDatePicker(),
          // Time Slots
          Expanded(
            child: _buildTimeSlots(timeSlots),
          ),
          // Confirm Booking Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedTimeSlot != null ? _confirmBooking : null,
              child: Text('Confirm Booking'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 14, // Show next 14 days
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool hasSlots = widget.specialist.schedule.containsKey(date);

          return GestureDetector(
            onTap: hasSlots
                ? () {
                    setState(() {
                      selectedDate = date;
                      selectedTimeSlot = null; // Reset selected time slot
                    });
                  }
                : null,
            child: Container(
              width: 80,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: date.day == selectedDate.day &&
                        date.month == selectedDate.month &&
                        date.year == selectedDate.year
                    ? Colors.blue
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hasSlots ? Colors.blue : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  '${date.day}/${date.month}',
                  style: TextStyle(
                    color: hasSlots ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlots(List<TimeSlot> timeSlots) {
    if (timeSlots.isEmpty) {
      return Center(
        child: Text('No available time slots on this date.'),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: timeSlots.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust as needed
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        TimeSlot slot = timeSlots[index];
        bool isSelected = selectedTimeSlot == slot;

        return GestureDetector(
          onTap: !slot.isBooked
              ? () {
                  setState(() {
                    selectedTimeSlot = slot;
                  });
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: slot.isBooked
                  ? Colors.grey
                  : isSelected
                      ? Colors.blue
                      : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: slot.isBooked
                    ? Colors.grey
                    : isSelected
                        ? Colors.blue
                        : Colors.black,
              ),
            ),
            child: Center(
              child: Text(
                slot.time.format(context),
                style: TextStyle(
                  color: slot.isBooked ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // lib/booking_page.dart

  void _confirmBooking() {
    if (selectedTimeSlot != null) {
      setState(() {
        selectedTimeSlot!.isBooked = true;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Booking Confirmed'),
          content: Text(
              'Your booking with ${widget.specialist.name} is confirmed for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} at ${selectedTimeSlot!.time.format(context)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

}
