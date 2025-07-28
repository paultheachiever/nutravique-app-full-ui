import 'package:flutter/material.dart';
import 'auth/login_screen.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String userType = 'patient';
  final _formKey = GlobalKey<FormState>();

  final formData = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': '',
    'confirmPassword': '',
    'phone': '',
    'dateOfBirth': '',
    'address': '',
    'specialty': '',
    'licenseNumber': '',
    'experience': '',
    'bio': '',
    'clinicName': '',
    'clinicAddress': '',
  };

  void handleInputChange(String field, String value) {
    setState(() {
      formData[field] = value;
    });
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      print("Registration attempt: $userType $formData");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Icon(Icons.favorite, color: Colors.blue, size: 40),
                const Text('Nutravique', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Create Your Account', style: TextStyle(fontSize: 20)),
                const Text('Join our healthcare community'),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ToggleButtons(
                        isSelected: [userType == 'patient', userType == 'doctor'],
                        onPressed: (index) {
                          setState(() {
                            userType = index == 0 ? 'patient' : 'doctor';
                          });
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(children: [Icon(Icons.person), SizedBox(width: 4), Text('Register as Patient')]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(children: [Icon(Icons.shield), SizedBox(width: 4), Text('Register as Doctor')]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      buildTextField('First Name', 'firstName'),
                      buildTextField('Last Name', 'lastName'),
                      buildTextField('Email', 'email', type: TextInputType.emailAddress),
                      buildTextField('Phone', 'phone', type: TextInputType.phone),
                      buildTextField('Password', 'password', isPassword: true),
                      buildTextField('Confirm Password', 'confirmPassword', isPassword: true),
                      if (userType == 'patient') ...[
                        buildTextField('Date of Birth', 'dateOfBirth', type: TextInputType.datetime),
                        buildTextField('Address', 'address', maxLines: 2),
                      ],
                      if (userType == 'doctor') ...[
                        DropdownButtonFormField<String>(
                          value: formData['specialty']!.isEmpty ? null : formData['specialty'],
                          onChanged: (value) => handleInputChange('specialty', value ?? ''),
                          items: const [
                            'Family Medicine',
                            'Internal Medicine',
                            'Pediatrics',
                            'Cardiology',
                            'Dermatology',
                            'Psychiatry',
                            'Orthopedics',
                            'Other'
                          ]
                              .map((label) => DropdownMenuItem(
                                    value: label.toLowerCase().replaceAll(' ', '-'),
                                    child: Text(label),
                                  ))
                              .toList(),
                          decoration: const InputDecoration(labelText: 'Medical Specialty'),
                        ),
                        buildTextField('License Number', 'licenseNumber'),
                        buildTextField('Years of Experience', 'experience', type: TextInputType.number),
                        buildTextField('Professional Bio', 'bio', maxLines: 3),
                        buildTextField('Clinic/Hospital Name', 'clinicName'),
                        buildTextField('Clinic Address', 'clinicAddress', maxLines: 2),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.blue[50],
                          child: Row(
                            children: const [
                              Icon(Icons.info_outline, color: Colors.blue),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'After registration, you will need to upload your medical credentials. Verification takes 2-3 days.',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: handleSubmit,
                        child: const Text('Create Account'),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login_screen');
                          },
                          child: const Text('Already have an account? Sign in'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String key,
      {bool isPassword = false, TextInputType type = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        obscureText: isPassword,
        keyboardType: type,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
        onChanged: (value) => handleInputChange(key, value),
        validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
      ),
    );
  }
}
