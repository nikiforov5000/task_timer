import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 2;

  @override
  Duration read(BinaryReader reader) {
    final int seconds = reader.readInt();
    return Duration(seconds: seconds);
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inSeconds);
  }
}

