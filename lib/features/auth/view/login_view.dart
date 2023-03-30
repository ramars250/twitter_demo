import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_demo/common/rounded_small_button.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/features/auth/view/signup_view.dart';
import 'package:twitter_demo/features/auth/widgets/auth_field.dart';
import 'package:twitter_demo/theme/theme.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    onTap: () {},
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
