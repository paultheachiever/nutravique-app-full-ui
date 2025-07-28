import 'package:flutter/material.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final todayAppointments = [
      {
        'id': 1,
        'patient': 'Jack kamau',
        'time': '9:00 AM',
        'type': 'Video Call',
        'status': 'upcoming',
        'reason': 'Follow-up consultation',
      },
      {
        'id': 2,
        'patient': 'James erick',
        'time': '10:30 AM',
        'type': 'In-Person',
        'status': 'in-progress',
        'reason': 'Annual check-up',
      },
      {
        'id': 3,
        'patient': 'Robert njihia',
        'time': '2:00 PM',
        'type': 'Video Call',
        'status': 'upcoming',
        'reason': 'Prescription review',
      },
    ];

    final recentPatients = [
      {
        'id': 1,
        'name': 'Sarah mark',
        'lastVisit': '2024-01-18',
        'condition': 'Hypertension',
        'status': 'stable',
      },
      {
        'id': 2,
        'name': 'David k',
        'lastVisit': '2024-01-17',
        'condition': 'Diabetes Type 2',
        'status': 'monitoring',
      },
      {
        'id': 3,
        'name': 'Lisa paul',
        'lastVisit': '2024-01-16',
        'condition': 'Anxiety',
        'status': 'improving',
      },
    ];

    final stats = {
      'Today Appointments': 8,
      'Total Patients': 247,
      'Pending Prescriptions': 5,
      'Monthly Consultations': 156,
    };

    final doctorData = {
      'name': 'Dr.  Paul Mwangi',
      'image': 'assets/placeholder-user.jpg',
      'specialty': 'Family Medicine',
      'todayAppointments': 8,
      'notificationCount': 5,
      'isOnline': true,
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorHeader(
  doctorName: doctorData['name'] as String,
  doctorImage: doctorData['image'] as String,
  specialty: doctorData['specialty'] as String,
  todayAppointments: doctorData['todayAppointments'] as int,
  notificationCount: doctorData['notificationCount'] as int,
  isOnline: doctorData['isOnline'] as bool,
),

              const SizedBox(height: 24),
              const Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              DoctorStats(stats: stats),
              const SizedBox(height: 24),
              const Text("Quick Actions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const DoctorQuickActions(),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: TodaysSchedule(appointments: todayAppointments)),
                            const SizedBox(width: 24),
                            Expanded(child: RecentPatients(patients: recentPatients)),
                          ],
                        )
                      : Column(
                          children: [
                            TodaysSchedule(appointments: todayAppointments),
                            const SizedBox(height: 24),
                            RecentPatients(patients: recentPatients),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorHeader extends StatelessWidget {
  final String doctorName;
  final String doctorImage;
  final String specialty;
  final int todayAppointments;
  final int notificationCount;
  final bool isOnline;

  const DoctorHeader({
    super.key,
    required this.doctorName,
    required this.doctorImage,
    required this.specialty,
    required this.todayAppointments,
    required this.notificationCount,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 28, backgroundImage: AssetImage(doctorImage)),
      title: Text(doctorName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(specialty),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle, color: isOnline ? Colors.green : Colors.grey, size: 14),
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications_none, size: 24),
              if (notificationCount > 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text('$notificationCount', style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class DoctorStats extends StatelessWidget {
  final Map<String, dynamic> stats;

  const DoctorStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats.entries.map((e) {
        return Container(
          width: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(e.value.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class DoctorQuickActions extends StatelessWidget {
  const DoctorQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.note_add), label: const Text("Add Note")),
        ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.medical_services), label: const Text("Prescribe")),
      ],
    );
  }
}

class TodaysSchedule extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const TodaysSchedule({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: appointments.map((appt) => Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(Icons.calendar_today),
          title: Text(appt['patient']),
          subtitle: Text("${appt['time']} - ${appt['reason']}"),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appt['type'], style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(appt['status'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      )).toList(),
    );
  }
}

class RecentPatients extends StatelessWidget {
  final List<Map<String, dynamic>> patients;

  const RecentPatients({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: patients.map((patient) => Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(patient['name']),
          subtitle: Text("${patient['condition']} - Last visit: ${patient['lastVisit']}"),
          trailing: Text(patient['status'], style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      )).toList(),
    );
  }
}
