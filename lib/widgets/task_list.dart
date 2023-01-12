import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totoey/models/task_data.dart';

import 'task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        print('TaskList -> Consumer -> builder');
        return GridView.count(
          crossAxisCount: 2,
          children: List.generate(taskData.taskCount, (index) {
            final task = taskData.getTaskAt(index);
            return TaskTile(
                task: task,
                onLongPress: () {
                  taskData.deleteTask(task);
                });
          }),
        );
      },
    );
  }
}