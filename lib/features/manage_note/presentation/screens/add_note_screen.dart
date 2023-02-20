import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/core/widgets/app_loader.dart';
import 'package:notes/core/widgets/app_toast.dart';
import 'package:notes/features/manage_note/domain/entities/user.dart';
import 'package:notes/features/manage_note/presentation/cubit/notes_cubit.dart';
import 'package:notes/features/manage_note/presentation/cubit/users_cubit.dart';
import 'package:notes/features/manage_note/presentation/widgets/default_text_form_field.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  void _getAllUsers() => context.read<UsersCubit>().getAllUsers();
  final Map<String, String> noteData = {'text': '', 'userId': ''};

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _getAllUsers();
  }

  void _onSave() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    await context.read<NotesCubit>().insertNote(
        id: '',
        text: noteData['text']!,
        userId: noteData['userId']!,
        placeDateTime: '');
    if (mounted) {
      Navigator.pop(context);
      context.read<NotesCubit>().getAllNotes();
      AppToast.build('Note has been Added Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: ((context, state) {
        if (state is AllUsersIsLoading) {
          return const AppLoader();
        } else if (state is AllUsersLoadedError) {
          return const Text('Error');
        } else if (state is AllUsersLoadedSuccess) {
          String dropdownValue = '';
          final users =
              state.users.map((User user) => user.username.toString()).toList();
          if (users.isNotEmpty) dropdownValue = users.first;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Note'),
              actions: [
                IconButton(
                  onPressed: () => _onSave(),
                  icon: const Icon(Icons.save_outlined),
                ),
              ],
            ),
            body: users.isEmpty
                ? const Center(
                    child: Text(
                        'There is no usres yet, please go to add new users'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          DefaultTextFormField(
                            label: 'Note',
                            isMultiLine: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter a Note';
                              } else {
                                return null;
                              }
                            },
                            onSave: (value) {
                              noteData['text'] = value;
                            },
                          ),
                          const SizedBox(height: 15),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Assign To User',
                            ),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            onSaved: (newValue) {
                              final user = state.users.firstWhere(
                                  (element) => element.username == newValue);
                              noteData['userId'] = user.id;
                            },
                            items: users
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        } else {
          return const AppLoader();
        }
      }),
    );
  }
}
