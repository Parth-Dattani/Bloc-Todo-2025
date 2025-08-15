import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/../models/task_response.dart'; // Import your model

class TaskStorage {
  static const taskKey = 'tasks';

  // Save tasks
  static Future<void> saveTasks(List<TaskResponse> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskJson = tasks.map((task) => task.toJson()).toList();
    await prefs.setString(taskKey, jsonEncode(taskJson));
  }

  // Load tasks
  static Future<List<TaskResponse>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(taskKey);
    if (jsonString == null) return [];
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => TaskResponse.fromJson(e)).toList();
  }
}
