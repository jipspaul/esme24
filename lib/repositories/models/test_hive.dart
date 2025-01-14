import 'package:hive_ce/hive.dart';

 //dart pub run build_runner build --delete-conflicting-outputs


class TestHive extends HiveObject {
  final String name;
  final int age;

  TestHive({required this.name, required this.age});
}