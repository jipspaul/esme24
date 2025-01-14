import 'package:hive_ce/hive.dart';
import 'package:swipezone/repositories/models/test_hive.dart';

class TestHiveObject {
  static const String boxName = 'testHive';

  static Future<void> init() async {
    await Hive.openBox<TestHive>(boxName);
  }

  static Box<TestHive> getBox() {
    return Hive.box<TestHive>(boxName);
  }

  static Future<void> add(TestHive testHive) async {
    final box = getBox();
    await box.add(testHive);
  }

  static List<TestHive> getAll() {
    final box = getBox();
    return box.values.toList();
  }

  static Future<void> update(int index, TestHive testHive) async {
    final box = getBox();
    await box.putAt(index, testHive);
  }

  static Future<void> delete(int index) async {
    final box = getBox();
    await box.deleteAt(index);
  }

  static Stream<BoxEvent> listen() {
    final box = getBox();
    return box.watch();
  }
}