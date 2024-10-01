// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String,
      time: fields[1] as String,
      date: fields[2] as String,
      periority: fields[3] as String,
      description: fields[4] as String,
      category: fields[5] as String,
      title: fields[6] as String,
      image: fields[7] as String,
      show: fields[8] as String,
      progress: fields[9] as String,
      status: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.periority)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.show)
      ..writeByte(9)
      ..write(obj.progress)
      ..writeByte(10)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
