import 'package:flutter/material.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/common%20_widgets/back_button.dart';
class SignInBar extends StatelessWidget {
  const SignInBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Row(
      children: [
        CustomBackButton(),
        SizedBox(
          width: 20,
        ),
        Text(
          'Sign in',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        )
      ],
    );
  }
}
