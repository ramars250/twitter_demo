import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_demo/common/common.dart';
import 'package:twitter_demo/features/auth/controller/auth_controller.dart';
import 'package:twitter_demo/features/auth/view/signup_view.dart';
import 'package:twitter_demo/features/home/view/home_view.dart';
import 'package:twitter_demo/theme/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  //const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      //當ref.watch的狀態為data時，代表已經有登入所以返回HomeView畫面，否則返回SignUpView畫面
      //當狀態為error時，返回一個帶有錯誤訊息的ErrorPage畫面
      //當裝泰為loaging時，返回LoadingPage畫面
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (error, st) => ErrorPage(
              error: error.toString(),
            ),
            //因為這裡還沒Scaffold，所以沒辦法直接使用Loader()，因此使用LoadingPage()
            loading: () => const LoadingPage(),
          ),
    );
  }
}
