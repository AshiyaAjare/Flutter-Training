import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _loadTasks();
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList('tasks') ?? [];
    
    if (tasksJson.isEmpty) {
      // Load default tasks if no saved tasks
      _tasks = [
        Task(
          id: '1',
          name: 'Drink water',
          createdAt: DateTime.now(),
        ),
        Task(
          id: '2',
          name: 'Meditate',
          createdAt: DateTime.now(),
        ),
        Task(
          id: '3',
          name: 'Walk',
          createdAt: DateTime.now(),
        ),
      ];
    } else {
      _tasks = tasksJson.map((taskJson) {
        final Map<String, dynamic> taskMap = json.decode(taskJson);
        return Task(
          id: taskMap['id'],
          name: taskMap['name'],
          notes: taskMap['notes'],
          createdAt: DateTime.parse(taskMap['createdAt']),
          isCompleted: taskMap['isCompleted'] ?? false,
        );
      }).toList();
    }
    notifyListeners();
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = _tasks.map((task) {
      return json.encode({
        'id': task.id,
        'name': task.name,
        'notes': task.notes,
        'createdAt': task.createdAt.toIso8601String(),
        'isCompleted': task.isCompleted,
      });
    }).toList();
    await prefs.setStringList('tasks', tasksJson);
  }

  void addTask(String name, String? notes) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      notes: notes,
      createdAt: DateTime.now(),
    );
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasks();
    notifyListeners();
  }

  void toggleTask(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      _saveTasks();
      notifyListeners();
    }
  }

  void clearAllTasks() {
    _tasks.clear();
    _saveTasks();
    notifyListeners();
  }

  int get completedTasksCount => _tasks.where((task) => task.isCompleted).length;
}

