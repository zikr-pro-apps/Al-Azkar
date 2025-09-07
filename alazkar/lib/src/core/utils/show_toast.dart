import 'package:alazkar/src/core/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: appThemeColor.withOpacity(.5),
  );
}
