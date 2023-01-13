import 'package:flutter/material.dart';

import '../main.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({required this.index});

  final int index;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    Task currentTask = box.getAt(widget.index);
    String name = currentTask.name;
    Duration timeLeft = currentTask.timeLeft;
    Duration timeTotal = currentTask.timeTotal;
    int color = currentTask.color;
    print('longPress on $name task');
    return Container();
  }
}
