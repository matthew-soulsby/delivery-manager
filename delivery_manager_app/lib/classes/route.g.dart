// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RouteAdapter extends TypeAdapter<Route> {
  @override
  final int typeId = 4;

  @override
  Route read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Route(
      date: fields[0] as DateTime,
      deliveries: (fields[1] as HiveList).castHiveList(),
      optimised: fields[2] as bool,
      indexesOfCompleted: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Route obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.deliveries)
      ..writeByte(2)
      ..write(obj.optimised)
      ..writeByte(3)
      ..write(obj.indexesOfCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
