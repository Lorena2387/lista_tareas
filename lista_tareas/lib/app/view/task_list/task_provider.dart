import 'package:flutter/material.dart';
import 'package:lista_tareas/app/models/task.dart';
import 'package:lista_tareas/app/repository/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  final TaskRepository _taskRepository = TaskRepository();

  Future<void> fetchTask() async {
    _taskList = await _taskRepository.getTasks();
    notifyListeners();
  }

  List<Task> get taskList => _taskList;
}
