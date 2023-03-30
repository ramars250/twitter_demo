import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/theme/theme.dart';

//因為AppBar有重複使用，所以直接拉出來寫成一個class來利用
//appBar: 後面不能直接輸入widget，所以改寫成這樣
class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        //appBar的title最高就是30
        height: 30,
      ),
      //設定置中
      centerTitle: true,
    );
  }
}