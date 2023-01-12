import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:totoey/constants.dart';

import '../models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  var onLongPress;

  TaskTile({
    required this.task,
    required this.onLongPress,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  Icon? buttonIcon;
  Timer? _timer;

  void updateTime() {
    if (widget.task.isDone) {
      return;
    }
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          widget.task.minusOneSecond();
          if (widget.task.timeLeft <= Duration(seconds: 0)) {
            widget.task.toggleDone();
            _timer!.cancel();
            toggleButtonIcon();
          }
        });
      });
    } else {
      _timer!.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: () {
        setState(() {
          widget.task.toggleRun();
        });
        toggleButtonIcon();
        updateTime();
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: PieChartWidget(
              timeLeft: widget.task.timeLeft,
              timeTotal: widget.task.timeTotal,
              color: widget.task.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [kCenterDiscShadow],
                  color: widget.task.isDone
                      ? kDisabledCenterDiscColor
                      : kEnabledCenterDiscColor),
            ),
          ),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: buttonIcon,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Text(
                    widget.task.name,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    style: widget.task.isDone
                        ? kDisabledTaskTitleTextStyle
                        : kEnabledTaskTitleTextStyle,
                  ),
                ),
              ),
              Center(
                child: Text(
                  durationToString(widget.task.timeLeft),
                  style: TextStyle(color: kLightGreyColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void toggleButtonIcon() {
    setState(
      () {
        buttonIcon = widget.task.isDone
            ? null
            : widget.task.isRunning
                ? Icon(
                    Icons.pause,
                    size: 400,
                    color: Colors.black.withOpacity(.1),
                  )
                : Icon(
                    Icons.play_arrow,
                    size: 400,
                    color: Colors.black.withOpacity(.1),
                  );
      },
    );
  }

  void resetTask() {
    widget.task.isDone = false;
    widget.task.isRunning = false;
    _timer!.cancel();
    widget.task.resetTimer();
    toggleButtonIcon();
  }
}

class PieChartWidget extends StatelessWidget {
  PieChartWidget(
      {required this.timeLeft, required this.timeTotal, required this.color});

  final Duration timeLeft;
  final Duration timeTotal;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: PieChart(
        animationDuration: Duration(seconds: 1),
        initialAngleInDegree: 270,
        legendOptions: LegendOptions(showLegends: false),
        chartValuesOptions: ChartValuesOptions(
          showChartValues: false,
        ),
        dataMap: {"Flutter": timeLeft.inSeconds * 1000.0},
        chartType: ChartType.disc,
        baseChartColor: kBaseChartColor,
        colorList: [Color(color)],
        totalValue: timeTotal.inSeconds * 1000.0,
      ),
    );
  }
}
