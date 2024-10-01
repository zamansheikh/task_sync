import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'text_field.dart';

class InputForm extends StatefulWidget {
  final Function() onFocusName;
  final Function() validateName;
  final bool correctName;
  final bool nameFocus;
  final TextEditingController passcontroller;
  final TextEditingController emailcontroller;
  final TextEditingController namecontroller;
  const InputForm({
    super.key,
    required this.onFocusName,
    required this.correctName,
    required this.nameFocus,
    required this.validateName,
    required this.passcontroller,
    required this.emailcontroller,
    required this.namecontroller,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool emailFocus = false;
  bool passwordFocus = false;
  bool correctEmail = false;
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          '  Name',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        InputField(
          onTap: () => widget.onFocusName(),
          focus: widget.nameFocus,
          passcontroller: TextEditingController(),
          hint: "Enter Your Name",
          correct: widget.correctName,
          onChange: widget.validateName,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '  Email',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() => InputField(
              onTap: () {
                setState(() {
                  emailFocus = true;
                  passwordFocus = false;
                });
              },
              focus: emailFocus,
              hint: "tim@gmail.com",
              passcontroller:widget.emailcontroller,
              correct: correctEmail,
              onChange: (){
                correctEmail = GetUtils.isEmail(widget.emailcontroller.text);
              },
            )),
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
        Obx(
          () => InputField(
            onTap: () {
              setState(() {
                emailFocus = false;
                passwordFocus = true;
              });
            },
            focus: passwordFocus,
            hint: "Pick a strong password",
            passcontroller: widget.passcontroller,
            hideText: showPassword,
            onChange: () {},
            showPass: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
