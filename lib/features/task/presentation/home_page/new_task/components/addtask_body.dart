import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/task/data/datasources/db_helper.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/progress_picker.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/title.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/upper_body.dart';

import '../../../../../auth/presentation/pages/components/button.dart';
import 'add_fild.dart';
import 'datetime_row.dart';
import 'image_container_list.dart';

class TaskBody extends StatefulWidget {
  const TaskBody({super.key});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  final DbHelper database = DbHelper();
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
  insertDataInDatabase() async {
    try {
      loading = true;
      await DbHelper()
          .insert(
        TaskModel(
            progress: progress.toInt().toString(),
            status: 'unComplete',
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            time: time,
            date: date,
            periority: lowPeriority ? 'High' : 'Low',
            description: description.text.toString(),
            category: category.text.toString(),
            title: title.text.toString(),
            image: Utils.getImage()[selectedImageIndex]!,
            show: 'yes'),
        "UID for USER",
      )
          .then((value) async {
        // homeController.getTaskData();
        title.clear();
        category.clear();
        date = '';
        time = '';
        progress = 0.0;
        selectedImageIndex = 1;
        await Future.delayed(const Duration(milliseconds: 700));
        loading = false;

        // Get.back();
      }).onError((error, stackTrace) {
        loading = false;
      });
    } catch (e) {
      loading = false;
      Utils.showSnackBar(
        context,
        'Warning',
        e.toString(),
        const Icon(
          FontAwesomeIcons.triangleExclamation,
          color: Colors.pinkAccent,
        ),
      );
    }
  }

  showProgressPicker(BuildContext context) {
    if (title.text.toString().isEmpty) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Add title of your task',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    if (category.text.toString().isEmpty) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Add category of your task',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    if (date.isEmpty) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Add date for your task',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    if (int.parse(Utils.getDaysDiffirece(date)) < 0) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Please select correct date',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    ProgressPicker(context);
  }

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

  setTitleFocus() {
    titleFocus = true;
    categoryFocus = false;
    descriptionFocus = false;
  }

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

  setImage(int index) {
    selectedImageIndex = index;
  }

  onTapOutside() {
    titleFocus = false;
    categoryFocus = false;
    descriptionFocus = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: 750,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UpperBody(),
            ImageContainerList(),
            const SizedBox(
              height: 20,
            ),
            TitlePeriority(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Category',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            AddInputField(
              controller: category,
              focus: categoryFocus,
              onTap: () => setCategoryFocus(),
              onTapOutSide: () => onTapOutside(),
              hint: 'Pick a Category',
              width: size.width,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Description',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            AddInputField(
              controller: description,
              focus: descriptionFocus,
              onTap: () => setDescriptionFocus(),
              onTapOutSide: () => onTapOutside(),
              hint: 'Enter description of your task (optional)',
              width: size.width,
            ),
            const SizedBox(
              height: 20,
            ),
            DateTimeRow(),
            const SizedBox(
              height: 20,
            ),
            AccountButton(
              text: 'Create Task',
              loading: loading,
              onTap: () async {
                // controller.insertDataInDatabase();
                showProgressPicker(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
