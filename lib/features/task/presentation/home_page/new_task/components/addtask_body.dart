import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_state.dart';
import 'package:task_sync/features/task/data/datasources/db_helper.dart';
import 'package:task_sync/features/task/data/models/task_model.dart';
import 'package:task_sync/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/progress_picker.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/title.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/components/upper_body.dart';

import '../../../../../auth/presentation/pages/widgets/button.dart';
import 'add_fild.dart';
import 'datetime_row.dart';
import 'image_container_list.dart';

class TaskBody extends StatefulWidget {
  final BuildContext parentContext;

  const TaskBody({super.key, required this.parentContext});

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
  double progressValue = 0.0;
  double progress = 0.0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String time = '';
  String date = '';

  bool verifyField(BuildContext context) {
    if (titleController.text.toString().isEmpty) {
      Utils.showSnackBar(
        context,
        'Add title of your task',
      );
      return false; // Return false if validation fails
    }
    if (categoryController.text.toString().isEmpty) {
      Utils.showSnackBar(
        context,
        'Add category of your task',
      );
      return false;
    }
    if (date.isEmpty) {
      Utils.showSnackBar(
        context,
        'Add date for your task',
      );
      return false;
    }
    if (int.parse(Utils.getDaysDiffirece(date)) < 0) {
      Utils.showSnackBar(
        context,
        'Please select correct date',
      );
      return false;
    }
    return true; // Return true if all fields are valid
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
              controller: categoryController,
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
              controller: descriptionController,
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
                setState(() {
                  loading = true;
                });
                final bool isValid = verifyField(context);

                // Check if fields are valid before proceeding
                if (!isValid) {
                  
                  return; // Return early if validation fails
                }

                showProgressPickerDialog(
                  context,
                  progressValue,
                  (newValue) {
                    setState(() {
                      progressValue =
                          newValue; // Update the value only when "OK" is pressed
                    });
                    print(progressValue);
                  },
                  () {
                    final String uid =
                        (context.read<AuthBloc>().state as AuthenticatedState)
                            .user
                            .uid;
                    context.read<TaskBloc>().add(
                          InsertTaskEvent(
                            TaskModel(
                              progress: progress.toInt().toString(),
                              status: 'unComplete',
                              id: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              time: time,
                              date: date,
                              periority: lowPeriority ? 'High' : 'Low',
                              description:
                                  descriptionController.text.toString(),
                              category: categoryController.text.toString(),
                              title: titleController.text.toString(),
                              image: Utils.getImage()[selectedImageIndex]!,
                              show: 'yes',
                            ),
                            uid,
                          ),
                        );
                  },
                );

                setState(() {
                  loading = false; // Stop loading after task creation
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
