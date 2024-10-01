import 'package:flutter/material.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/spec/animated_input_field.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController nameController;
  const SignUpForm({
    super.key,
    required this.emailController,
    required this.passController,
    required this.nameController,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool correctEmail = false;
  void validateEmail() {
    setState(() {
      correctEmail = widget.emailController.text.contains('@') &&
          widget.emailController.text.contains('.');
    });
  }

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool showPassword = true;

  bool isEmail(String text) {
    return text.contains('@') && text.contains('.');
  }

  bool isName(String text) {
    return text.length > 3;
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      setState(() {});
    });
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Text(
          'Name',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(height: 10),
        AnimatedInputField(
          focusNode: _nameFocusNode,
          controller: widget.nameController,
          hint: "Zaman Sheikh",
          correct: isName(widget.nameController.text),
          onChange: () {
            setState(() {}); // Trigger a rebuild
          },
          onTap: () {
            _passwordFocusNode.unfocus();
            _emailFocusNode.unfocus();
            _nameFocusNode.requestFocus();
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(height: 10),
        AnimatedInputField(
          focusNode: _emailFocusNode,
          controller: widget.emailController,
          hint: "zaman@gmail.com",
          correct: isEmail(widget.emailController.text),
          onChange: () {
            setState(() {}); // Trigger a rebuild
          },
          onTap: () {
            _passwordFocusNode.unfocus();
            _nameFocusNode.unfocus();
            _emailFocusNode.requestFocus();
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(height: 10),
        AnimatedInputField(
          focusNode: _passwordFocusNode,
          controller: widget.passController,
          hint: "Pick a strong password",
          isObscure: showPassword,
          onChange: () {
            setState(() {});
          },
          onTap: () {
            _emailFocusNode.unfocus();
            _nameFocusNode.unfocus();
            _passwordFocusNode.requestFocus();
          },
          showPass: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
