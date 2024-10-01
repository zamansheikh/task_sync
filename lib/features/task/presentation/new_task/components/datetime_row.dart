import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_sync/core/utils/utils.dart';

import 'date_time_container.dart';

class DateTimeRow extends StatefulWidget {
  const DateTimeRow({super.key});

  @override
  State<DateTimeRow> createState() => _DateTimeRowState();
}

class _DateTimeRowState extends State<DateTimeRow> {
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

  pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      date.value = Utils.formateDate(pickedDate);
    }
  }

  picTime(BuildContext context) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      DateFormat dateFormat = DateFormat('hh:mm a');
      time.value = dateFormat.format(DateTime(
        2323,
        1,
        1,
        pickedTime.hour,
        pickedTime.minute,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => DateTimeContainer(
                  text: date.value.isEmpty ? 'dd/mm/yyyy' : date.value,
                  icon: const Icon(
                    FontAwesomeIcons.calendar,
                    color: Colors.white24,
                    size: 20,
                  ),
                  onTap: () {
                    pickDate(context);
                  },
                ))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Time',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              TextSpan(
                text: '   (optional)',
                style: TextStyle(color: Colors.white30, fontSize: 13),
              )
            ])),
            const SizedBox(
              height: 10,
            ),
            Obx(() => DateTimeContainer(
                  text: time.value.isEmpty ? 'hh/mm' : time.value,
                  icon: const Icon(
                    Icons.watch,
                    color: Colors.white24,
                    size: 20,
                  ),
                  onTap: () {
                    picTime(context);
                  },
                ))
          ],
        )
      ],
    );
  }
}
