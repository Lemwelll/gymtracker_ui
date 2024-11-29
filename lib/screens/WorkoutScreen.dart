import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  String _selectedDay = 'Monday'; // Default day

  // Tips for each day of the week
  final Map<String, String> _dailyTips = {
    'Monday': 'Focus on Chest: Bench Press, Push-Ups, Chest Flyes.',
    'Tuesday': 'Leg Day: Squats, Lunges, Deadlifts.',
    'Wednesday': 'Back Day: Pull-Ups, Rows, Deadlifts.',
    'Thursday': 'Shoulder Day: Overhead Press, Lateral Raises.',
    'Friday': 'Arms Day: Bicep Curls, Tricep Dips, Push-Ups.',
    'Saturday': 'Core Day: Planks, Crunches, Russian Twists.',
    'Sunday': 'Active Recovery: Light Cardio, Stretching, Yoga.',
  };

  // Daily workout counts
  final Map<String, int> _workoutCounts = {
    'Monday': 0,
    'Tuesday': 0,
    'Wednesday': 0,
    'Thursday': 0,
    'Friday': 0,
    'Saturday': 0,
    'Sunday': 0,
  };

  void _markAsDone() {
    setState(() {
      _workoutCounts[_selectedDay] = _workoutCounts[_selectedDay]! + 1; // Increment count for the selected day
    });
    // Show a snackbar to confirm the action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Workout for $_selectedDay marked as done!')),
    );
  }

  void _setDay(String day) {
    setState(() {
      
      _selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gym-related Icon
              Icon(
                Icons.fitness_center,
                size: 100,
                color: Colors.white70,
              ),
              const SizedBox(height: 20),

              // Daily Tip Selector
              DropdownButton<String>(
                value: _selectedDay,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _setDay(newValue);
                  }
                },
                items: _dailyTips.keys.map<DropdownMenuItem<String>>((String day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day, style: const TextStyle(color: Color.fromARGB(255, 228, 220, 220))),
                  );
                }).toList(),
                style: const TextStyle(color: Colors.black),
                dropdownColor: const Color.fromARGB(255, 20, 15, 15),
              ),
              const SizedBox(height: 20),

              // Display the tip for the selected day
              Text(
                _dailyTips[_selectedDay] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Display the workout count for the selected day
              Text(
                "Workouts Completed on $_selectedDay: ${_workoutCounts[_selectedDay]}",
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Button to mark workout as done
              ElevatedButton.icon(
                onPressed: _markAsDone,
                icon: const Icon(Icons.check),
                label: const Text("Mark as Done"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 205, 209, 206), // A green color for "done"
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
