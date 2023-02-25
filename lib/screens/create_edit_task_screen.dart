import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totoey/constants.dart';
import 'package:totoey/models/task_data.dart';

import '../main.dart';
import '../models/task.dart';

class CreateEditTaskScreen extends StatefulWidget {
  final int index;

  CreateEditTaskScreen({required this.index});

  @override
  State<CreateEditTaskScreen> createState() => _CreateEditTaskScreenState();
}

class _CreateEditTaskScreenState extends State<CreateEditTaskScreen> {
  late String _name;
  late Duration _timeTotal;
  late Color _color;
  late Task task;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.index == -1) {
      _name = '';
      _timeTotal = Duration(seconds: 0);
      _color = TaskColors.getRandomColor();
    } else {
      task = box.getAt(widget.index);
      _name = task.name;
      _timeTotal = task.timeTotal;
      _color = Color(task.color);
    }
    controller.text = _name;
  }

  void onAddSaveTaskCallback() {
    if (_timeTotal == Duration(seconds: 0)) {
      _showMyDialog(context, 'Please enter duration');
    } else if (_name == '') {
      _showMyDialog(context, 'Please enter task name');
    } else {
      task = Task(
        name: _name,
        timeTotal: _timeTotal,
        timeLeft: _timeTotal,
        color: _color.value,
      );

      if (widget.index == -1) {
        Provider.of<TaskData>(context, listen: false).addNewTask(task);
      } else {
        Provider.of<TaskData>(context, listen: false).updateTask(widget.index, task);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
      decoration: const BoxDecoration(
        color: kSemiLightGreyColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.5),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                _name = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: kLightGreyColor,
                    )),
                hintText: 'Enter task name',
                hintStyle: TextStyle(
                    color: kLightGreyColor, fontWeight: FontWeight.w100),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddTaskScreenButton(
                label: widget.index == -1 ? 'Add Task' : 'Save Task',
                color: _color,
                onTap: onAddSaveTaskCallback,
              ),
              SizedBox(
                width: 10,
              ),
              AddTaskScreenButton(
                label: 'Change color',
                color: _color,
                onTap: () {
                  setState(() {
                    _color = TaskColors.getRandomColor();
                  });
                },
              ),
            ],
          ),
          DurationPicker(
            duration: _timeTotal,
            onChange: (value) {
              setState(() {
                _timeTotal = value;
              });
            },
          ),
          widget.index == -1
              ? Container()
              : AddTaskScreenButton(
                  label: 'Delete Task',
                  color: _color.withOpacity(.5),
                  onTap: onDeleteCallback)
        ],
      ),
    );
  }

  onDeleteCallback() {
    Provider.of<TaskData>(context, listen: false).deleteTask(widget.index);
    Navigator.pop(context);
  }
}

class AddTaskScreenButton extends StatelessWidget {
  const AddTaskScreenButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
