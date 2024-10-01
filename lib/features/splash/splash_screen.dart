import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sync/core/constants/app_images.dart';
import '../../../routes/routes.dart';
import 'package:task_sync/features/splash/cubit/splash_cubit.dart';

import '../../core/constants/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoggedIn) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homePage,
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signInScreen,
            (Route<dynamic> route) => false,
          );
        }
        if (state is SplashError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred'),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: black,
        body: Center(
          child: Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        offset: const Offset(1, 1)),
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        offset: const Offset(-1, -1))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(AppImage.splash),
              )),
        ),
      ),
    );
  }
}
