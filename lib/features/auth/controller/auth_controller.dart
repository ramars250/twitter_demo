// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_demo/apis/auth_api.dart';
import 'package:twitter_demo/core/core.dart';

//建立StateNotifierProvider，監聽bool值並回傳給AuthController
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    //這裡的state等於上面的bool值
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => print(r.email),
    );
  }
}
