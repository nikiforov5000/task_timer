import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:random_string_generator/random_string_generator.dart';

import '../main.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {
  Timer? timer;
  var randString = RandomStringGenerator(fixedLength: 3);
  Random random = Random();

  void addNewTask(Task task) {
    box.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    box.deleteAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void updateTask(int index, Task task) {
    box.putAt(index, task);
    notifyListeners();
  }
}
