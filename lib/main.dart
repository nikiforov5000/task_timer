import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:totoey/models/task_data.dart';
import 'package:totoey/screens/tasks_screen.dart';

import 'durationAdapter.dart';
import 'models/task.dart';

late Box box;

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(DurationAdapter());

  box = await Hive.openBox('tasksBox');

  Task task = Task(
      name: 'name',
      timeTotal: Duration(seconds: 34),
      timeLeft: Duration(seconds: 10),
      color: Colors.red.value);

  box.add(task);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
