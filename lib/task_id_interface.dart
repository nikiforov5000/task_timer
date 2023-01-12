
import 'main.dart';

class TaskId {
  static int _id = 0;

  static getId() {
    print('getId');
    return ++_id;
  }
}

