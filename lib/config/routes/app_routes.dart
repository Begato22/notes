import 'package:flutter/material.dart';
import 'package:notes/features/manage_note/presentation/screens/add_note_screen.dart';
import 'package:notes/features/manage_note/presentation/screens/add_user_screen.dart';
import 'package:notes/features/manage_note/presentation/screens/setting_screen.dart';

import '../../features/manage_note/presentation/screens/notes_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String addNote = '/add-note';
  static const String updateNote = '/updateNote';
  static const String addUser = '/add-user';
  static const String options = '/options';
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const NotesScreen(),
        );
      case Routes.addNote:
        return MaterialPageRoute(
          builder: (context) => const AddNoteScreen(),
        );
      case Routes.addUser:
        return MaterialPageRoute(
          builder: (context) => const AddUserScreen(),
        );
      case Routes.options:
        return MaterialPageRoute(
          builder: (context) => const SettingScreen(),
        );
      // case Routes.activateTagRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider<ActivateTagCubit>(
      //       create: (context) => di.sl<ActivateTagCubit>(),
      //       child: const ActivateTagScreen(),
      //     ),
      //   );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            'undefined Page :{',
          ),
        ),
      ),
    );
  }
}
