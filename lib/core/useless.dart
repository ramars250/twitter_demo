import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
//利用ImagePicker來選擇多張圖片並回傳List<File>的物件
Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for(final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}
