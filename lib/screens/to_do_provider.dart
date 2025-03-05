import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => _tasks;

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, String updatedTask) {
    _tasks[index] = updatedTask;
    notifyListeners();
  }
}


