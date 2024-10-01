import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import for FontAwesomeIcons
import 'package:task_sync/core/constants/app_color.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/textfield_sufiix.dart';

class AnimatedInputField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hint;
  final bool? isObscure;
  final bool correct;
  final VoidCallback onChange;
  final VoidCallback onTap;
  final VoidCallback? showPass;

  const AnimatedInputField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.hint,
    this.isObscure,
    this.correct = false,
    required this.onChange,
    required this.onTap,
    this.showPass,
  });

  @override
  State<AnimatedInputField> createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<AnimatedInputField> {
  bool isEmail(String text) {
    return text.contains('@') && text.contains('.');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: widget.focusNode.hasFocus
            ? const LinearGradient(colors: [
                Colors.purpleAccent,
                Colors.pink,
              ])
            : null,
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        onChanged: (value) {
          widget.onChange(); // Call the onChange function
        },
        obscureText:
            widget.isObscure ?? false, // Use widget to access properties
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          filled: true,
          suffixIcon: widget.isObscure == null
              ? widget.correct == true
                  ? const TextFieldSufix(icon: Icons.done)
                  : null
              : widget.controller.text.isNotEmpty
                  ? GestureDetector(
                      onTap: widget.showPass,
                      child: widget.isObscure ?? false
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
          hintText: widget.hint,
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12),
        ),
      ),
    );
  }
}
