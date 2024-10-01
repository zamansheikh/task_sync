import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:task_sync/features/auth/presentation/pages/widgets/button.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/spec/icon_container.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/common%20_widgets/back_button.dart';
import 'package:task_sync/injection_container.dart';
import 'package:task_sync/routes/routes.dart';

import '../../../../core/constants/app_color.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool nameFocus = false;
  bool emailFocus = false;
  bool passwordFocus = false;
  bool correctEmail = false;
  bool correctName = false;
  bool showPassword = true;
  bool loading = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  void validateEmail() {
    correctEmail = Utils.validateEmail(emailController.text.toString());
  }

  void validateName() {
    correctName = nameController.text.toString().length > 5;
  }

  void setLoading(bool value) {
    loading = value;
  }

  void createAccount() {
    if (!correctName) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Enter Correct Name',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (!correctEmail) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Enter Correct Email',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (passwordController.text.toString().length < 6) {
      Utils.showSnackBar(
          context,
          'Warning',
          'Password length should greater than 5',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    sl<AuthRemoteDataSource>().signUpWithEmailAndPassword(
        emailController.text.toString(), passwordController.text.toString());
    // FirebaseService.createAccount();
  }

  void onFocusEmail() {
    emailFocus = true;
    nameFocus = false;
    passwordFocus = false;
  }

  void onFocusName() {
    emailFocus = false;
    nameFocus = true;
    passwordFocus = false;
  }

  void onFocusPassword() {
    emailFocus = false;
    nameFocus = false;
    passwordFocus = true;
  }

  void onTapOutside(BuildContext context) {
    emailFocus = false;
    nameFocus = false;
    passwordFocus = false;
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Row(
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
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sign up with one of the following options.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          sl<AuthRemoteDataSource>().signUpWithGoogle(),
                      child: const IconContainer(
                          widget: Icon(
                        FontAwesomeIcons.google,
                        size: 18,
                        color: Colors.white,
                      )),
                    ),
                    const IconContainer(
                        widget: Icon(
                      Icons.apple_rounded,
                      color: Colors.white,
                    )),
                  ],
                ),
                // InputForm(),
                AccountButton(
                  text: "Create Account",
                  loading: false,
                  onTap: () {
                    createAccount();
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.signInScreen);
                      },
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ))
                      ])),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
