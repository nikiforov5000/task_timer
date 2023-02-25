import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:totoey/models/task_data.dart';
import 'package:totoey/screens/auth_screen.dart';
import 'package:totoey/screens/tasks_screen.dart';

import 'durationAdapter.dart';
import 'models/task.dart';

late Box box;

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(DurationAdapter());

  box = await Hive.openBox('tasksBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: AuthScreen(),
      ),
    );
  }
}
