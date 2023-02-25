import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totoey/models/task_data.dart';
import 'package:totoey/screens/edit_task_screen.dart';

import '../main.dart';
import '../screens/create_edit_task_screen.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        print('TaskList -> Consumer -> builder');
        return GridView.count(
          crossAxisCount: 2,
          children: List.generate(box.length, (index) {
            final task = box.getAt(index);
            return TaskTile(
                task: task,
                onLongPress: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => CreateEditTaskScreen(index: index),
                  );
                });
          }),
        );
      },
    );
  }
}



