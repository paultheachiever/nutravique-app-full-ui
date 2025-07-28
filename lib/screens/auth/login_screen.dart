// lib/login_screen.dart
import 'package:flutter/material.dart';
import '../home/patient_dashboard.dart';
import '../home/doctor_dashboard.dart';
import 'register_dashboard.dart';


class LoginScreen extends StatefulWidget {
final String role; 

  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPatient = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/nutravique.png',
                width: 120,
                height: 120,

              ),
              const SizedBox(height: 20),
              const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Sign in to your account", style: TextStyle(fontSize: 16, color: Colors.grey)),

              const SizedBox(height: 24),

             

              const SizedBox(height: 24),

              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
                ),
              ),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                 if (widget.role == 'patient') {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const PatientDashboardScreen()),
  );
} else if (widget.role == 'doctor') {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const DoctorDashboard()),
  );
}

                  

                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Sign In"),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                       Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const RegisterPage()),
  );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
