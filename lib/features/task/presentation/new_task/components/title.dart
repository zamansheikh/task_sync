import 'package:flutter/material.dart';
import 'package:task_sync/features/task/presentation/new_task/components/add_fild.dart';
import 'package:task_sync/features/task/presentation/new_task/components/periority_container.dart';

class TitlePeriority extends StatefulWidget {
  const TitlePeriority({super.key});

  @override
  State<TitlePeriority> createState() => _TitlePeriorityState();
}

class _TitlePeriorityState extends State<TitlePeriority> {
  int selectedImageIndex = 1;
  bool lowPeriority = true;
  bool titleFocus = false;
  bool categoryFocus = false;
  bool descriptionFocus = false;
  bool loading = false;
  double progress = 0.0;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  String time = '';
  String date = '';
  setCategoryFocus() {
    titleFocus = false;
    categoryFocus = true;
    descriptionFocus = false;
  }

  setDescriptionFocus() {
    titleFocus = false;
    categoryFocus = false;
    descriptionFocus = true;
  }

  setPeriority(bool value) {
    lowPeriority = value;
  }

  setTitleFocus() {
    titleFocus = true;
    categoryFocus = false;
    descriptionFocus = false;
  }

  onTapOutside() {
    titleFocus = false;
    categoryFocus = false;
    descriptionFocus = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            AddInputField(
              controller: title,
              focus: titleFocus,
              onTap: () => setTitleFocus(),
              onTapOutSide: () => onTapOutside(),
              hint: 'Enter task title',
              width: size.width / 2.2,
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Periority',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PeriorityContainer(
                    onTap: () => setPeriority(true),
                    focus: lowPeriority,
                    type: "Low"),
                const SizedBox(
                  width: 5,
                ),
                PeriorityContainer(
                    onTap: () => setPeriority(false),
                    focus: !lowPeriority,
                    type: "High"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
