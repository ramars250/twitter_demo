// ignore_for_file: avoid_print
import 'package:appwrite/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_demo/apis/auth_api.dart';
import 'package:twitter_demo/apis/user_api.dart';
import 'package:twitter_demo/core/core.dart';
import 'package:twitter_demo/features/auth/view/login_view.dart';
import 'package:twitter_demo/features/home/view/home_view.dart';
import 'package:twitter_demo/models/user_model.dart';

//建立StateNotifierProvider，監聽bool值並回傳給AuthController
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

//使用FutureProvider來提供當前用戶的信息，需要先獲取當前用戶的ID，然後使用
//userDetailsProvider來獲取用的的詳細訊息，最後返回用戶的詳細信息
final currentUserDetailProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

//建立userDetailsProvider，希望一個String的uid並返回一個UserModel對象
final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

//建立currentUserAccountProvider等於FutureProvider，並利用authControllerProvider
//獲取authController，然後調用authController.currentUser來獲取當前使用者的帳戶資訊
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

//當用戶登入時將狀態改為true，登出時為false
class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  //建立currentUser用於獲取當前用戶資訊並返回一個Future的model.Account類，如果沒有已經登入的用戶則返回null
  Future<model.Account?> currentUser() => _authAPI.currentUserAccount();

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
    state = false;
    //fold是由Either提供的一種方式，可以處理正確和錯誤的情況
    //res是一個Either的實例，所以可能是一個成功或一個錯誤
    //所以當成功的時候調用(r)，失敗則調用(l)
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isTwitterBlue: false,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, '帳戶創建完成，請進行登入');
          Navigator.push(context, LoginView.route());
        });
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.push(context, HomeView.route());
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updateUser = UserModel.fromMap(document.data);
    return updateUser;
  }
}
