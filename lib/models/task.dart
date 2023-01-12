import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {

  @HiveField(0)
  final String name;

  @HiveField(1)
  Duration timeLeft;

  @HiveField(2)
  final Duration timeTotal;

  @HiveField(3)
  bool isRunning = false;

  @HiveField(4)
  bool isDone = false;

  @HiveField(5)
  final int color;

  Task({required this.name, required this.timeTotal, required this.timeLeft, required this.color});

  void toggleDone() {
    isDone = !isDone;
  }

  void toggleRun() {
    isRunning = !isRunning;
  }

  void resetTimer() {
    timeLeft = timeTotal;
  }

  void minusOneSecond() {
    print('task.dart -> minusOneSecond');
    timeLeft -= const Duration(seconds: 1);
  }

}
