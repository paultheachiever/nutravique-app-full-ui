import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          // 🔹 Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/join.jpg', // <-- Replace with your actual image path
              fit: BoxFit.fill,
            ),
          ),

          // 🔹 Optional overlay for better contrast
          Container(
            color: Colors.black.withOpacity(0.08),
          ),

          // 🔹 Foreground content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Continue as:",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(role: 'patient'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person),
                  label: const Text("Patient"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(role: 'doctor'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.medical_services),
                  label: const Text("Doctor"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
