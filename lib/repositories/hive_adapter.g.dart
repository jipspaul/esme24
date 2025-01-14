// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapter.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class TestHiveAdapter extends TypeAdapter<TestHive> {
  @override
  final int typeId = 0;

  @override
  TestHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestHive(
      name: fields[0] as String,
      age: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, TestHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
