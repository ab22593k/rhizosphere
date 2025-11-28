import 'package:hive/hive.dart';

enum PostureState { folded, unfolded, partiallyFolded, unsupported }

class DevicePostureAdapter extends TypeAdapter<PostureState> {
  @override
  final int typeId = 0;

  @override
  PostureState read(BinaryReader reader) {
    return PostureState.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, PostureState obj) {
    writer.writeByte(obj.index);
  }
}

class PostureStorage {
  static const String boxName = 'device_posture';
  static const String key = 'current_posture';

  Future<void> savePosture(PostureState state) async {
    final box = await Hive.openBox<PostureState>(boxName);
    await box.put(key, state);
  }

  Future<PostureState?> getPosture() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<PostureState>(boxName);
    }
    return Hive.box<PostureState>(boxName).get(key);
  }
}
