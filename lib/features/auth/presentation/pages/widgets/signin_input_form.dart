import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_sync/core/constants/app_color.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/textfield_sufiix.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool correctEmail = false;
  bool nameFocus = false;
  void validateEmail() {
    setState(() {
      correctEmail =
          emailController.text.contains('@'); // Simple email validation
    });
  }

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool showPassword = true;

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
          'Email',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(height: 10),
        _buildInputField(
          focusNode: _emailFocusNode,
          controller: emailController,
          hint: "zaman@gmail.com",
          correct: isEmail(emailController.text),
          onChange: () {
            setState(() {}); // Trigger a rebuild
          },
          onTap: () {
            _emailFocusNode.requestFocus();
            _passwordFocusNode.unfocus(); // Unfocus password field
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(height: 10),
        _buildInputField(
          focusNode: _passwordFocusNode,
          controller: passController,
          hint: "Pick a strong password",
          hideText: showPassword,
          onChange: () {},
          onTap: () {
            _passwordFocusNode.requestFocus();
            _emailFocusNode.unfocus(); // Unfocus email field
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

  Widget _buildInputField({
    required FocusNode focusNode,
    required TextEditingController controller,
    required String hint,
    bool? hideText,
    bool? correct,
    required VoidCallback onChange,
    required VoidCallback onTap,
    VoidCallback? showPass,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: focusNode.hasFocus
            ? const LinearGradient(colors: [
                Colors.purpleAccent,
                Colors.pink,
              ])
            : null,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        onChanged: (value) {
          onChange();
        },
        obscureText: hideText ?? false,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          filled: true,
          suffixIcon: hideText == null
              ? correct == true
                  ? const TextFieldSufix(icon: Icons.done)
                  : null
              : controller.text.isNotEmpty
                  ? GestureDetector(
                      onTap: showPass,
                      child: hideText
                          ? const TextFieldSufix(
                              icon: FontAwesomeIcons.eye,
                              size: 13,
                            )
                          : const TextFieldSufix(
                              icon: FontAwesomeIcons.eyeLowVision,
                              size: 13,
                            ),
                    )
                  : const SizedBox(),
          fillColor: primaryColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          hoverColor: Colors.pinkAccent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          hintText: hint,
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12),
        ),
      ),
    );
  }

  bool isEmail(String text) {
    return text.contains('@');
  }
}
