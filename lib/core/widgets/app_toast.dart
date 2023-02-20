import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/config/routes/app_navigator.dart';

class AppToast {
  static build(String msg) {
    ScaffoldMessenger.of(AppNavigator.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Center(child: Text(msg)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey.withOpacity(0.8),
      elevation: 0,
      width: 0.7.sw,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
    ));
  }
}
