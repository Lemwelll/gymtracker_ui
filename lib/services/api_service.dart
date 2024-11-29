import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000'; // Replace with your backend URL

  // Fetch user profile
  static Future<Map<String, dynamic>?> fetchUserProfile() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/profile'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Failed to fetch profile: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
    return null;
  }

  // Update user profile
  static Future<bool> updateUserProfile(
      String name, String gender, int age, String address) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/profile'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'gender': gender,
          'age': age,
          'address': address,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Failed to update profile: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error updating profile: $e");
    }
    return false;
  }

  // Fetch workout progress
  static Future<Map<String, dynamic>?> fetchWorkoutProgress() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/workouts'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Failed to fetch workout progress: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error fetching workout progress: $e");
    }
    return null;
  }

  // Mark workout as done for a specific day
  static Future<bool> markWorkoutDone(String day) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/workouts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'day': day}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Failed to mark workout as done: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error marking workout as done: $e");
    }
    return false;
  }
}
