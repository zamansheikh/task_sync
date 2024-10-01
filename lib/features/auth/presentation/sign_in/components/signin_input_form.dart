import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          '  Email',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        //  InputField(
        //     onTap: () => controller.onFocusEmail(),
        //     focus: controller.emailFocus.value,
        //     hint: "tim@gmail.com",
        //     passcontroller: controller.email.value,
        //     correct: controller.correctEmail.value,
        //     onChange: controller.validateEmail,
        //   ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '  Password',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        // InputField(
        //   onTap: () => controller.onFocusPassword(),
        //   focus: controller.passwordFocus.value,
        //   hint: "Pick a strong password",
        //   controller: controller.password.value,
        //   hideText: controller.showPassword.value,
        //   onChange: () {},
        //   showPass: () => controller.showPassword.toggle(),
        // ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
