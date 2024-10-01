import 'package:flutter/widgets.dart';
import 'package:task_sync/features/auth/presentation/sign_in/sign_in.dart';
import 'package:task_sync/features/splash/splash_screen.dart';
import 'routes.dart';
import '../features/task/presentation/home_page/home_page.dart';
import '../features/auth/presentation/sign_up/sign_up.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext context)> routes() {
    return {
      Routes.splashScreen: (context) => SplashScreen(),
      Routes.signInScreen: (context) => SignIn(),
      Routes.signUpScreen: (context) => SignUp(),
      Routes.homePage: (context) => HomePage(),
    };
  }
}
