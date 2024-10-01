import 'package:flutter/material.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/common%20_widgets/back_button.dart';


class SignUpBar extends StatelessWidget {
  const SignUpBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Row(
      children: [
        CustomBackButton(),
        SizedBox(
          width: 20,
        ),
        Text(
          'Sign up',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )
      ],
    );
  }
}
