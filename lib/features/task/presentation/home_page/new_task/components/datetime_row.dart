import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_sync/core/utils/utils.dart';

import 'date_time_container.dart';

class DateTimeRow extends StatefulWidget {
  const DateTimeRow({super.key});

  @override
  State<DateTimeRow> createState() => _DateTimeRowState();
}

class _DateTimeRowState extends State<DateTimeRow> {
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

  pickDate(BuildContext context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      date = Utils.formateDate(pickedDate);
    }
  }

  picTime(BuildContext context) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      DateFormat dateFormat = DateFormat('hh:mm a');
      time = dateFormat.format(DateTime(
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
            DateTimeContainer(
              text: date.isEmpty ? 'dd/mm/yyyy' : date,
              icon: const Icon(
                FontAwesomeIcons.calendar,
                color: Colors.white24,
                size: 20,
              ),
              onTap: () {
                pickDate(context);
              },
            )
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
            DateTimeContainer(
              text: time.isEmpty ? 'hh/mm' : time,
              icon: const Icon(
                Icons.watch,
                color: Colors.white24,
                size: 20,
              ),
              onTap: () {
                picTime(context);
              },
            )
          ],
        )
      ],
    );
  }
}
