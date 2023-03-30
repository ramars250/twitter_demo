import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_demo/common/common.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/features/auth/controller/auth_controller.dart';
import 'package:twitter_demo/features/auth/view/login_view.dart';
import 'package:twitter_demo/features/auth/widgets/auth_field.dart';
import 'package:twitter_demo/theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  const SignUpView({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
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

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          //先前設定signup時建構的BuildContext上下文就是要用在這邊的
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
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
                    onTap: onSignUp,
                    label: '註冊',
                  ),
                ),
                const SizedBox(height: 40),
                // textspan
                RichText(
                  text: TextSpan(
                      text: "註冊帳號?",
                      style: const TextStyle(fontSize: 16),
                      children: [
                        TextSpan(
                          text: ' 登入',
                          style: const TextStyle(
                              color: Pallete.blueColor, fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, LoginView.route());
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
