import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/auth/data/auth_remote_data_source.dart';
import 'package:task_sync/features/auth/presentation/sign_up/components/appbar.dart';
import 'package:task_sync/features/auth/presentation/sign_up/components/button.dart';
import 'package:task_sync/features/auth/presentation/sign_up/components/signup_options.dart';
import 'package:task_sync/injection_container.dart';
import 'package:task_sync/routes/routes.dart';

import '../../../../core/constants/app_color.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RxBool nameFocus = false.obs;
  RxBool emailFocus = false.obs;
  RxBool passwordFocus = false.obs;
  RxBool correctEmail = false.obs;
  RxBool correctName = false.obs;
  RxBool showPassword = true.obs;
  RxBool loading = false.obs;
  // final FirebaseServices firebase=FirebaseServices();
  final email = TextEditingController().obs;
  final name = TextEditingController().obs;
  final password = TextEditingController().obs;
  void validateEmail() {
    correctEmail.value = Utils.validateEmail(email.value.text.toString());
  }

  void validateName() {
    correctName.value = name.value.text.toString().length > 5;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void createAccount() {
    if (!correctName.value) {
      Utils.showSnackBar(
          'Warning',
          'Enter Correct Name',
          const Icon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.pink,
          ));
      return;
    }
    if (!correctEmail.value) {
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
    sl<AuthRemoteDataSource>().signUpWithEmailAndPassword(
        email.value.text.toString(), password.value.text.toString());
    // FirebaseService.createAccount();
  }

  void onFocusEmail() {
    emailFocus.value = true;
    nameFocus.value = false;
    passwordFocus.value = false;
  }

  void onFocusName() {
    emailFocus.value = false;
    nameFocus.value = true;
    passwordFocus.value = false;
  }

  void onFocusPassword() {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = true;
  }

  void onTapOutside(BuildContext context) {
    emailFocus.value = false;
    nameFocus.value = false;
    passwordFocus.value = false;
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
                const SignUpBar(),
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
                const SignUpOptions(),
                // InputForm(),
                Obx(
                  () => AccountButton(
                    text: "Create Account",
                    loading: false,
                    onTap: () {
                      createAccount();
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.signInScreen),
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
