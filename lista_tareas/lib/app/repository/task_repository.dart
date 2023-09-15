import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskRepository {
  Future<bool> addTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTask = prefs.getStringList('tasks') ?? [];
    jsonTask.add(jsonEncode(task.toJson()));
    return prefs.setStringList('tasks', jsonTask);
  }

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTask = prefs.getStringList('tasks') ?? [];
    return jsonTask
        .map((jsonTask) => Task.fromJson(jsonDecode(jsonTask)))
        .toList();
  }

  Future<bool> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonTask = tasks.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('tasks', jsonTask);
  }
}
