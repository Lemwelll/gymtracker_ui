import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome Message
              Text(
                "Welcome to Your Gym Tracker!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Bright white for visibility
                ),
              ),
              const SizedBox(height: 20),

              // Simple Tip or Quote
              Text(
                "Consistency is key to achieving your goals.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70, // Slightly lighter color
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[900], // Dark background
    );
  }
}