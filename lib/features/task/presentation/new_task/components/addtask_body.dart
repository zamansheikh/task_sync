import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/task/data/datasources/db_helper.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/presentation/new_task/components/progress_picker.dart';
import 'package:task_sync/features/task/presentation/new_task/components/title.dart';
import 'package:task_sync/features/task/presentation/new_task/components/upper_body.dart';

import '../../../../auth/presentation/sign_up/components/button.dart';
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
  insertDataInDatabase() async {
    try {
      loading.value = true;
      await DbHelper()
          .insert(
        TaskModel(
            progress: progress.value.toInt().toString(),
            status: 'unComplete',
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            time: time.value,
            date: date.value,
            periority: lowPeriority.value ? 'High' : 'Low',
            description: description.value.text.toString(),
            category: category.value.text.toString(),
            title: title.value.text.toString(),
            image: Utils.getImage()[selectedImageIndex.value]!,
            show: 'yes'),
        "UID for USER",
      )
          .then((value) async {
        // homeController.getTaskData();
        title.value.clear();
        category.value.clear();
        date.value = '';
        time.value = '';
        progress.value = 0.0;
        selectedImageIndex.value = 1;
        await Future.delayed(const Duration(milliseconds: 700));
        loading.value = false;

        Get.back();
      }).onError((error, stackTrace) {
        loading.value = false;
      });
    } catch (e) {
      loading.value = false;
      Utils.showSnackBar(
          'Warning',
          e.toString(),
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
    }
  }

  showProgressPicker(BuildContext context) {
    if (title.value.text.toString().isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'Add title of your task',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    if (category.value.text.toString().isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'Add category of your task',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    if (date.value.isEmpty) {
      Utils.showSnackBar(
          'Warning',
          'Add date for your task',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ));
      return;
    }
    if (int.parse(Utils.getDaysDiffirece(date.value)) < 0) {
      Utils.showSnackBar(
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

  setTitleFocus() {
    titleFocus.value = true;
    categoryFocus.value = false;
    descriptionFocus.value = false;
  }

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

  setImage(int index) {
    selectedImageIndex.value = index;
  }

  onTapOutside() {
    titleFocus.value = false;
    categoryFocus.value = false;
    descriptionFocus.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: 750,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => AddInputField(
              controller: category.value,
              focus: categoryFocus.value,
              onTap: () => setCategoryFocus(),
              onTapOutSide: () => onTapOutside(),
              hint: 'Pick a Category',
              width: size.width,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Description',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => AddInputField(
              controller: description.value,
              focus: descriptionFocus.value,
              onTap: () => setDescriptionFocus(),
              onTapOutSide: () => onTapOutside(),
              hint: 'Enter description of your task (optional)',
              width: size.width,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DateTimeRow(),
          const SizedBox(
            height: 20,
          ),
          Obx(() => AccountButton(
                text: 'Create Task',
                loading: loading.value,
                onTap: () async {
                  // controller.insertDataInDatabase();
                  showProgressPicker(context);
                },
              ))
        ]),
      ),
    );
  }
}
