import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_sync/core/constants/app_color.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/textfield_sufiix.dart';

class SignInForm extends StatefulWidget {
  final Function() onFocusName;
  final Function() validateName;
  final bool correctName;
  final bool nameFocus;
  final TextEditingController passController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  const SignInForm({
    super.key,
    required this.onFocusName,
    required this.correctName,
    required this.nameFocus,
    required this.validateName,
    required this.passController,
    required this.emailController,
    required this.nameController,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool correctEmail = false; // Adjust based on your validation logic
  bool nameFocus = false; // Add focus management logic if necessary

  // Simulated method for validating email (you can replace this with your logic)
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
          'Name',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(height: 10),
        _buildInputField(
          focusNode: _nameFocusNode,
          controller: widget.nameController,
          hint: "Enter Your Name",
          correct: widget.correctName,
          onChange: widget.validateName,
          onTap: () {
            widget.onFocusName();
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
        _buildInputField(
          focusNode: _emailFocusNode,
          controller: widget.emailController,
          hint: "zaman@gmail.com",
          correct: isEmail(widget.emailController.text),
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
          controller: widget.passController,
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
