import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void checkUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? user = pref.getString('TOKEN');
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        emit(SplashLoggedIn(user));
      } else {
        emit(SplashInitial());
      }
    });
  }
}
