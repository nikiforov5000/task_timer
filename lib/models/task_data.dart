import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:random_string_generator/random_string_generator.dart';

import 'task.dart';

class TaskData extends ChangeNotifier {
  Timer? timer;
  var randString = RandomStringGenerator(fixedLength: 3);
  Random random = Random();

  // final List<Task> _tasks = List.generate(10, (_) {
  //   return Task(
  //       name: 's d f s  sd f f fd s s d fg ds s df fs s sd df',
  //       timeTotal: Duration(seconds: 23),
  //       timeLeft: Duration(seconds: 3),
  //       color: TaskColors.getRandomColor().value,
  //   );
  // });
  // final List<Task> _tasks = [
  //   Task(
  //     name: 'play tetris',
  //     timeTotal: Duration(seconds: 23),
  //     timeLeft: Duration(seconds: 3),
  //     color: Colors.red.value,
  //   )
  // ];
  // final List<Task> _tasks = [box.get('firstTask')];
  final List<Task> _tasks = [];

  void addNewTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  UnmodifiableListView<Task> getTasks() {
    return UnmodifiableListView(_tasks);
  }

  Task getTaskAt(int index) {
    return _tasks[index];
  }

  int get taskCount {
    return _tasks.length;
  }

  void deleteTask(Task task) {
    task.isDone = true;
    _tasks.remove(task);
    notifyListeners();
  }

  void startTimer() {
    if (timer == null || !timer!.isActive) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => minusSecondForAllRunning(),
      );
    }
  }

  minusSecondForAllRunning() {
    _tasks.map((task) {
      if (task.isRunning) {
        task.minusOneSecond();
      }
    });
    notifyListeners();
  }

  void toggleRun(Task task) {
    task.toggleRun();
  }

  void setDone(Task task) {
    task.toggleDone();
    task.toggleRun();
  }
}
