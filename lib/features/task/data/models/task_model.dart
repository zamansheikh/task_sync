// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:task_sync/features/task/domain/entities/task.dart';

part 'task_model.g.dart'; // This is for the generated adapter

@HiveType(typeId: 0) // Assign a unique typeId for TaskModel
class TaskModel extends Task {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String time;

  @override
  @HiveField(2)
  final String date;

  @override
  @HiveField(3)
  final String periority;

  @override
  @HiveField(4)
  final String description;

  @override
  @HiveField(5)
  final String category;

  @override
  @HiveField(6)
  final String title;

  @override
  @HiveField(7)
  final String image;

  @override
  @HiveField(8)
  final String show;

  @override
  @HiveField(9)
  final String progress;

  @override
  @HiveField(10)
  final String status;

  const TaskModel({
    required this.id,
    required this.time,
    required this.date,
    required this.periority,
    required this.description,
    required this.category,
    required this.title,
    required this.image,
    required this.show,
    required this.progress,
    required this.status,
  }) : super(
          id: id,
          time: time,
          date: date,
          periority: periority,
          description: description,
          category: category,
          title: title,
          image: image,
          show: show,
          progress: progress,
          status: status,
        );

  TaskModel.fromMap(Map<String, dynamic> res)
      : this(
          id: res['id'],
          title: res['title'],
          category: res['category'],
          description: res['description'],
          image: res['image'],
          periority: res['periority'],
          show: res['show'],
          time: res['time'],
          date: res['date'],
          progress: res['progress'],
          status: res['status'],
        );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'image': image,
      'periority': periority,
      'time': time,
      'date': date,
      'show': show,
      'status': status,
      'progress': progress,
    };
  }

  // CopyWith method for TaskModel
  TaskModel copyWith({
    String? id,
    String? time,
    String? date,
    String? periority,
    String? description,
    String? category,
    String? title,
    String? image,
    String? show,
    String? progress,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      time: time ?? this.time,
      date: date ?? this.date,
      periority: periority ?? this.periority,
      description: description ?? this.description,
      category: category ?? this.category,
      title: title ?? this.title,
      image: image ?? this.image,
      show: show ?? this.show,
      progress: progress ?? this.progress,
      status: status ?? this.status,
    );
  }
}
