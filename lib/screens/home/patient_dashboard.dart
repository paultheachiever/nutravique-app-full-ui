import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // light gray bg
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good morning, John!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            Text("How are you feeling today?", style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell),
            color: Colors.grey[600],
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: const Icon(LucideIcons.user, color: Colors.blue),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Quick Actions
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _quickAction(LucideIcons.calendar, "Book", "Appointment", Colors.blue),
                _quickAction(LucideIcons.video, "Video Call", "Telemedicine", Colors.green),
                _quickAction(LucideIcons.pill, "Prescriptions", "View & Download", Colors.purple),
                _quickAction(LucideIcons.heart, "Health", "Tracker", Colors.red),
              ],
            ),
            const SizedBox(height: 20),

            // Upcoming Appointments
            _card(
              title: "Upcoming Appointments",
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: const Icon(LucideIcons.user, color: Colors.blue),
                ),
                title: const Text("Dr. Sarah Smith", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Family Medicine", style: TextStyle(fontSize: 12)),
                    Text("Tomorrow, 2:00 PM", style: TextStyle(fontSize: 11)),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Video Call", style: TextStyle(fontSize: 11, color: Colors.green)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Health Summary
            _card(
              title: "Health Summary",
              child: Column(
                children: const [
                  _healthTile("Blood Pressure", "120/80", Colors.green),
                  _healthTile("Heart Rate", "72 bpm", Colors.green),
                  _healthTile("Weight", "165 lbs", Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.calendar), label: "Appointments"),
          BottomNavigationBarItem(icon: Icon(LucideIcons.messageSquare), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: "Profile"),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String title, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
      ]),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
      ]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Icon(LucideIcons.chevronRight, size: 18, color: Colors.grey),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _healthTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _healthTile(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
