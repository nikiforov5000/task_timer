import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totoey/constants.dart';
import 'package:totoey/screens/add_task_screen.dart';
import 'package:totoey/widgets/task_list.dart';

import '../main.dart';
import '../models/task_data.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSemiLightGreyColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kLightGreyColor,
        child: const Icon(
          Icons.add,
          color: kDarkGreyColor,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Container(
              child: AddTaskScreen(),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 30, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Task Timer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  '${box.length} tasks',
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 0,
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: kSemiDarkGreyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(
                  // taskList: tasks,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
