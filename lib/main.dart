import 'package:flutter/material.dart';
import 'screens/home/roles_dashboard.dart';
import 'screens/home/splash_screen.dart';


void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutravique',
      debugShowCheckedModeBanner: false,
 initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/roleSelection': (context) => const RoleSelectionScreen(),
      },    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "icon": "calendar_today",
      "title": "Book Appointments Easily",
      "description":
          "Find and book appointments\nwith verified doctors based on\nspecialty and location",
      "image": "assets/images/appointment.jpg"
    },
    {
      "icon": "chat",
      "title": "Consult Doctors Remotely",
      "description": "Use chat or video call to get\nprofessional medical advice",
       "image": "assets/images/consult.jpg"

    },
    {
      "icon": "medical_services",
      "title": "Manage Your Prescriptions",
      "description": "Access prescriptions and\nmedications all in one place",
      "image": "assets/images/presc.jpg"

    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _skip() {
    _finishOnboarding();
  }

 void _finishOnboarding() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    var data = onboardingData[index];
                    return Stack(
  fit: StackFit.expand,
  children: [
    // Background image
    Image.asset(
      data["image"]!,
      fit: BoxFit.cover,
    ),

    // Dark overlay (optional, for better contrast)
    Container(color: Colors.black.withOpacity(0.09)),

    // Foreground content
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white.withOpacity(0.9),
            child: Icon(
              _getIconData(data["icon"]!),
              size: 60,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            data["title"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data["description"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    )
  ],
);

                  },
                ),
              ),

              const SizedBox(height: 20),

              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => buildDot(index == _currentPage),
                ),
              ),

              const SizedBox(height: 30),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Skip
              TextButton(
                onPressed: _skip,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for dots
 Widget buildDot(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 12 : 10,
    height: isActive ? 12 : 10,
    decoration: BoxDecoration(
      color: isActive ? Colors.blue : Colors.grey[300],
      shape: BoxShape.circle,
    ),
  );
}


  // Convert string icon name to IconData
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'calendar_today':
        return Icons.calendar_today;
      case 'chat':
        return Icons.chat;
      case 'medical_services':
        return Icons.medical_services;
      default:
        return Icons.help_outline;
    }
  }
}
