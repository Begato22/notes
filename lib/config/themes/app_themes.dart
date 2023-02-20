import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    primarySwatch: AppColors.primarySwatch,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: AppStrings.fontFamily,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme(),
    elevatedButtonTheme: _elevatedButtonThemeData(),
    appBarTheme: AppBarTheme(
        // backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22.sp,
        ),
        iconTheme: IconThemeData(color: AppColors.whiteColor)),
  );
}

TextTheme _textTheme = TextTheme(
  // headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
  // headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
  // headline3: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
  // headline4: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
  // headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
  // headline6: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),

  headlineSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
      color: AppColors.blackColor),
  headlineMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22.sp,
      color: AppColors.blackColor),
  headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30.sp,
      color: AppColors.blackColor),

  // overline: const TextStyle(),
  labelSmall: TextStyle(color: AppColors.whiteColor, fontSize: 12.sp),
  labelMedium: TextStyle(color: AppColors.whiteColor, fontSize: 14.sp),
  labelLarge: TextStyle(color: AppColors.whiteColor, fontSize: 18.sp),

  // subtitle1: TextStyle(fontSize: 16.sp, color: Colors.grey),
  // subtitle2: TextStyle(fontSize: 14.sp, color: Colors.grey),
  titleSmall: TextStyle(fontSize: 12.sp, color: Colors.grey),
  titleMedium: TextStyle(fontSize: 14.sp, color: Colors.grey),
  titleLarge: TextStyle(fontSize: 16.sp, color: Colors.grey),

  // displaySmall:TextStyle(),
  // displayMedium:TextStyle(),
  // displayLarge:TextStyle(),

  // caption: TextStyle(height: 1.5, color: AppColors.primaryColor),
  bodySmall: TextStyle(fontSize: 12.sp, color: AppColors.blackColor),
  // bodyText1: const TextStyle(height: 1.5, color: Colors.white),
  // bodyText2: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.primaryColor),
  bodyMedium: TextStyle(fontSize: 14.sp, color: AppColors.blackColor),
  bodyLarge: TextStyle(fontSize: 16.sp, color: AppColors.blackColor),
);

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    //  labelStyle: TextStyle(color: Colors.blue),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.r),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColors.secondryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.r),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColors.primaryColor,
      ),
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.primaryColor,
      minimumSize: Size(double.infinity, 40.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
      elevation: 0,
      textStyle: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),
    ),
  );
}

class AppTheme {
  static BoxDecoration appBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15.r),
    border: Border.all(
      style: BorderStyle.solid,
      color: AppColors.secondryColor,
    ),
  );
}
