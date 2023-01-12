
import 'main.dart';

class TaskId {
  static int _id = box.keys.last;

  static getId() {
    print('getId');
    return ++_id;
  }
}

