import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_demo/common/loading_page.dart';
import 'package:twitter_demo/common/rounded_small_button.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/features/auth/controller/auth_controller.dart';
import 'package:twitter_demo/features/auth/view/signup_view.dart';
import 'package:twitter_demo/features/auth/widgets/auth_field.dart';
import 'package:twitter_demo/theme/theme.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  //讓appbar可以每次不進行重構
  final appbar = UIConstants.appBar();

  //建立輸入框的變數
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // textfield 1
                      AuthField(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(height: 25),
                      // textfield 2
                      AuthField(
                        controller: passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(height: 40),
                      // button
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: onLogin,
                          label: '登入',
                        ),
                      ),
                      const SizedBox(height: 40),
                      // textspan
                      RichText(
                        text: TextSpan(
                            text: "沒有帳號?",
                            style: const TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: ' 註冊',
                                style: const TextStyle(
                                    color: Pallete.blueColor, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, SignUpView.route());
                                  },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
