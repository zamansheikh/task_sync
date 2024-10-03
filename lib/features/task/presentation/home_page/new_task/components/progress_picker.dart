import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_color.dart';

class ProgressPickerDialog extends StatefulWidget {
  final double initialValue;
  final Function(double) onValueChanged;
  final Function() onConfirm;

  const ProgressPickerDialog({
    super.key,
    required this.initialValue,
    required this.onValueChanged,
    required this.onConfirm,
  });

  @override
  ProgressPickerDialogState createState() => ProgressPickerDialogState();
}

class ProgressPickerDialogState extends State<ProgressPickerDialog> {
  late double currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
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
              fontSize: 17,
            ),
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
                '${currentValue.toInt()}%',
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
          value: currentValue,
          onChanged: (val) {
            setState(() {
              currentValue = val; // Update local value
            });
            widget.onValueChanged(val); // Pass the updated value back to parent
          },
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog without changes
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onConfirm(); // Confirm action
                  Navigator.pop(context); // Close the dialog with changes
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// Function to display the dialog
void showProgressPickerDialog(
  BuildContext context,
  double initialValue,
  Function(double) onValueChanged,
  Function() onConfirm,
) {
  showDialog(
    context: context,
    builder: (context) {
      return ProgressPickerDialog(
        onConfirm: onConfirm,
        initialValue: initialValue,
        onValueChanged: onValueChanged, // Pass as callback
      );
    },
  );
}
