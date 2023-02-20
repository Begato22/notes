import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notes/core/utils/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitFadingCircle(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.white,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven
                    ? AppColors.primaryColor
                    : AppColors.secondryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
