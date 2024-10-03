import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_sync/core/utils/utils.dart';
import 'package:task_sync/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_sync/features/auth/presentation/bloc/auth_state.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/button.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/spec/icon_container.dart';
import 'package:task_sync/features/task/presentation/home_page/new_task/common%20_widgets/back_button.dart';
import 'package:task_sync/injection_container.dart';

import '../../../../core/constants/app_color.dart';

import '../../../../../routes/routes.dart';
import 'package:task_sync/features/auth/presentation/pages/widgets/signin_input_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Utils.showSnackBar(
            context,
            state.message,
          );
        }
        if (state is AuthLoading) {
          setState(() {
            loading = true;
          });
        } else {
          setState(() {
            loading = false;
          });
        }
        if (state is AuthenticatedState) {
          Utils.showSnackBar(
            context,
            "You have successfully logged in",
          );
          Navigator.pushNamed(context, Routes.homePage);
        }
      },
      child: Scaffold(
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
                        'Sign in',
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
                    'Sign in with one of the following options.',
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
                  SignInForm(
                    emailController: emailController,
                    passController: passwordController,
                  ),
                  AccountButton(
                    text: "Login Account",
                    loading: loading,
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                          email: emailController.text.trim(),
                          password: passwordController.text.toString()));
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signUpScreen);
                        },
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
      ),
    );
  }
}
