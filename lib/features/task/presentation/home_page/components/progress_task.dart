import 'package:flutter/material.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/presentation/home_page/components/progress_container.dart';

class ProgressTask extends StatefulWidget {
  final List<TaskModel> taskList;
  const ProgressTask({super.key, required this.taskList});

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {
  List list = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.taskList.length,
        itemBuilder: (context, index) {
          if (widget.taskList[index].show == 'yes') {
            return GestureDetector(
                onTap: () {
                  // controller.removeFromList(index);
                },
                child: ProgressContainer(index: index));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
