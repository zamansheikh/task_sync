import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../constants/app_color.dart';

class Utils {
  static bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  static String extractFirebaseError(String error) {
    return error.substring(error.indexOf(']') + 1);
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: primaryColor.withOpacity(.4),
      content: Row(
        children: [
          Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pinkAccent,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Warning", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(message),
              ],
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String formateDate(DateTime date) {
    String formattedDate = DateFormat('d MMM y').format(date);
    return formattedDate;
  }

  static String formatDate() {
    String formattedDate = DateFormat('EEEE, d').format(DateTime.now());
    return formattedDate;
  }

  static Map<int, String> getImage() {
    return {
      1: 'assets/images/back2.jpg',
      2: 'assets/images/back3.jpg',
      3: 'assets/images/back1.jpg',
    };
  }

  static String getDaysDiffirece(String dateString) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateTime date = dateFormat.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    return (-1 * difference.inDays).toString();
  }

  static Future<void> showWarningDailog(
      BuildContext context, VoidCallback onConfirm) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('Are you sure you want to do this action ?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                onConfirm();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
