import 'package:hive_ce/hive.dart';
import 'package:swipezone/repositories/models/test_hive.dart';

part 'hive_adapter.g.dart';

@GenerateAdapters([
  AdapterSpec<TestHive>(),
])
// This is for code generation
// ignore: unused_element
void _() {}