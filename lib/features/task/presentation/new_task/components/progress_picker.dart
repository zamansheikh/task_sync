import 'package:flutter/material.dart';
import '../../../../../core/constants/app_color.dart';

class ProgressPicker {
  ProgressPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: primaryColor,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Set Progress',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '100 loading%',
                    style: const TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Slider(
              min: 0.0,
              max: 100.0,
              activeColor: Colors.pinkAccent,
              value: 14.4, //infuture use progress.value
              onChanged: (value) {
                // controller.progress.value = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        // Get.back();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      )),
                  TextButton(
                      onPressed: () {
                        // Get.back();
                        // controller.insertDataInDatabase();
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
