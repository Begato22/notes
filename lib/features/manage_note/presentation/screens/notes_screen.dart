import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/config/routes/app_routes.dart';
import 'package:notes/core/utils/app_strings.dart';
import 'package:notes/core/widgets/app_loader.dart';
import 'package:notes/features/manage_note/presentation/cubit/notes_cubit.dart';
import 'package:notes/features/manage_note/presentation/widgets/notes_box.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  _getAllNotes() => BlocProvider.of<NotesCubit>(context).getAllNotes();

  @override
  void initState() {
    _getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is AllNotesIsLoading) {
          return const AppLoader();
        } else if (state is AllNotesLoadedError) {
          return const Text('Error');
        } else if (state is AllNotesLoadedSuccess) {
          // var cubit = context.read<NotesCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.appTitle),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.addUser);
                  },
                  child: const Icon(Icons.person_add_alt),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.options);
                    },
                    child: const Icon(Icons.settings)),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.menu),
                ),
                SizedBox(width: 10.w),
              ],
            ),
            body: NoteBox(note: state.note),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, Routes.addNote),
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const AppLoader();
        }
      },
    );
  }
}
