import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_sync/features/task/presentation/new_task/components/periority_container.dart';

import 'add_fild.dart';

class TitlePeriority extends StatefulWidget {
  const TitlePeriority({super.key});

  @override
  State<TitlePeriority> createState() => _TitlePeriorityState();
}

class _TitlePeriorityState extends State<TitlePeriority> {
  RxInt selectedImageIndex = 1.obs;
  RxBool lowPeriority = true.obs;
  RxBool titleFocus = false.obs;
  RxBool categoryFocus = false.obs;
  RxBool descriptionFocus = false.obs;
  RxBool loading = false.obs;
  RxDouble progress = 0.0.obs;
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> category = TextEditingController().obs;
  RxString time = ''.obs;
  RxString date = ''.obs;
  setCategoryFocus() {
    titleFocus.value = false;
    categoryFocus.value = true;
    descriptionFocus.value = false;
  }

  setDescriptionFocus() {
    titleFocus.value = false;
    categoryFocus.value = false;
    descriptionFocus.value = true;
  }

  setPeriority(bool value) {
    lowPeriority.value = value;
  }

  setTitleFocus() {
    titleFocus.value = true;
    categoryFocus.value = false;
    descriptionFocus.value = false;
  }

  onTapOutside() {
    titleFocus.value = false;
    categoryFocus.value = false;
    descriptionFocus.value = false;
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
              controller: title.value,
              focus: titleFocus.value,
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
                Obx(
                  () => PeriorityContainer(
                      onTap: () => setPeriority(true),
                      focus: lowPeriority.value,
                      type: "Low"),
                ),
                const SizedBox(
                  width: 5,
                ),
                Obx(() => PeriorityContainer(
                    onTap: () => setPeriority(false),
                    focus: !lowPeriority.value,
                    type: "High")),
              ],
            ),
          ],
        )
      ],
    );
  }
}
