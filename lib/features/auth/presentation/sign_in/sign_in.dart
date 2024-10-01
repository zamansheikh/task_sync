import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/auth/data/auth_remote_data_source.dart';
import 'package:task_sync/features/auth/presentation/sign_up/components/button.dart';
import 'package:task_sync/features/auth/presentation/sign_up/components/signup_options.dart';
import 'package:task_sync/injection_container.dart';

import '../../../../core/constants/app_color.dart';

import '../../../../../routes/routes.dart';
import 'package:task_sync/features/auth/presentation/sign_in/components/signin_bar.dart';
import 'package:task_sync/features/auth/presentation/sign_in/components/signin_input_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool emailFocus = false;
  bool passwordFocus = false;
  bool correctEmail = false;
  bool showPassword = true;
  bool loading = false;
  final email = TextEditingController();
  final password = TextEditingController();

  void loginAccount() {
    if (!correctEmail) {
      Utils.showSnackBar(
          'Warning',
          'Enter Correct Email',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (password.value.text.toString().length < 6) {
      Utils.showSnackBar(
          'Warning',
          'Password length should greater than 5',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }

    sl<AuthRemoteDataSource>().loginWithEmailAndPassword(
        email.value.text.toString(), password.value.text.toString());
    // FirebaseService.loginAccount();
  }

  void setLoading(bool value) {
    loading = value;
  }

  void validateEmail() {
    correctEmail = Utils.validateEmail(email.value.text.toString());
  }

  void onFocusEmail() {
    emailFocus = true;
    passwordFocus = false;
  }

  void onFocusPassword() {
    emailFocus = false;
    passwordFocus = true;
  }

  void onTapOutside(BuildContext context) {
    emailFocus = false;
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
                const SignInBar(),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sign in with one of the following options.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SignUpOptions(),
                SignInForm(),
                Obx(
                  () => AccountButton(
                    text: "Login Account",
                    loading: loading,
                    onTap: () {
                      loginAccount();
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.signUpScreen),
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        TextSpan(
                            text: 'Sign up',
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
