import 'dart:core';

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String? id;
  final String? title;
  final String? category;
  final String? description;
  final String? image;
  final String? periority;
  final String? time;
  final String? date;
  final String? show;
  final String? progress;
  final String? status;

  const Task({
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
  });

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        description,
        image,
        periority,
        time,
        date,
        show,
        progress,
        status,
      ];
}
