import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/manage_note/presentation/cubit/options_cubit.dart';
import 'package:notes/features/manage_note/presentation/cubit/users_cubit.dart';

import '../../features/manage_note/presentation/cubit/notes_cubit.dart';
import 'package:notes/injection_container.dart' as di;

class AppBlocProviders {
  static final blocProviders = [
    BlocProvider<NotesCubit>(create: (context) => di.sl<NotesCubit>()),
    BlocProvider<UsersCubit>.value(value: di.sl<UsersCubit>()),
    BlocProvider<OptionsCubit>.value(value: di.sl<OptionsCubit>()),
  ];
}
