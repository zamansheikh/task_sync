import 'package:flutter/material.dart';
import 'package:task_sync/features/task/presentation/components/progress_container.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

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
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index].show == 'yes') {
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
