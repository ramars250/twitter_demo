import 'package:flutter/material.dart';
import 'package:twitter_demo/theme/theme.dart';

//因為有相同的輸入框，所以拉出來做方便重複使用
//做成構造函數是因為可以利用輸入不同的字串來進行區別
class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Pallete.blueColor, width: 3),
        ),
        //未點選時的邊框
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.greyColor,
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}
