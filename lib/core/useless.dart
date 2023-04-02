import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getNameFromEmail(String email) {
  //(拆分) AAA@com.tw
  //會變成List = [AAA, @com.tw]
  //然後我們取一個元素所以得到@前方字元
  return email.split('@')[0];
}
