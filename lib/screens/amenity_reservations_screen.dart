import 'package:flutter/material.dart';

class AmenityReservationsScreen extends StatefulWidget {
  const AmenityReservationsScreen({Key? key}) : super(key: key);

  @override
  State<AmenityReservationsScreen> createState() =>
      _AmenityReservationsScreenState();
}

class _AmenityReservationsScreenState extends State<AmenityReservationsScreen> {
  String _selectedAmenity = 'Pool';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _makeReservation() {
    // TODO: Implement reservation logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reservation made successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amenity Reservations'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Amenity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedAmenity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'Pool',
                      'Gym',
                      'Party Room',
                      'BBQ Area',
                      'Tennis Court',
                      'Meeting Room',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAmenity = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Date'),
                    subtitle: Text(
                      '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _selectDate,
                  ),
                  ListTile(
                    title: const Text('Time'),
                    subtitle: Text(_selectedTime.format(context)),
                    trailing: const Icon(Icons.access_time),
                    onTap: _selectTime,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _makeReservation,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Make Reservation'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Reservations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReservationItem(
                    'Pool',
                    'Tomorrow, 2:00 PM',
                    Icons.pool,
                  ),
                  _buildReservationItem(
                    'BBQ Area',
                    'Next Saturday, 6:00 PM',
                    Icons.outdoor_grill,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationItem(String amenity, String time, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(amenity),
      subtitle: Text(time),
      trailing: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          // TODO: Implement cancellation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reservation cancelled'),
            ),
          );
        },
      ),
    );
  }
}
