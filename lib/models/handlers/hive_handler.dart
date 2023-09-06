import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveHandler {
  static final HiveHandler _instance = HiveHandler._internal();

  factory HiveHandler() {
    return _instance;
  }

  HiveHandler._internal();

  Box? _box;

  Future<void> initHive(List<String> boxNames) async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    for (final boxName in boxNames) {
      await Hive.openBox(boxName);
    }
  }

  Future<void> put(String boxName, String key, dynamic value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  dynamic get(String boxName, String key) {
    final box = Hive.box(boxName);
    return box.get(key);
  }

  Future<void> delete(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> close() async {
    await Hive.close();

  }


}
