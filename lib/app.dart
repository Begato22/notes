import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/bloc setting/app_bloc_providers.dart';
import 'config/routes/app_navigator.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_themes.dart';
import 'core/utils/app_strings.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.blocProviders,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: AppStrings.appTitle,
            theme: appTheme(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoute.onGenerateRoute,
            navigatorKey: AppNavigator.navigatorKey,
          );
        },
        // child: QuoteScreen(),
      ),
    );
  }
}
