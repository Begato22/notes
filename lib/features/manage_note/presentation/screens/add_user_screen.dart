import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/utils/app_images.dart';
import 'package:notes/core/widgets/app_loader.dart';
import 'package:notes/core/widgets/app_toast.dart';
import 'package:notes/features/manage_note/domain/entities/intrest.dart';
import 'package:notes/features/manage_note/presentation/cubit/notes_cubit.dart';
import 'package:notes/features/manage_note/presentation/cubit/users_cubit.dart';
import 'package:notes/features/manage_note/presentation/widgets/default_text_form_field.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  void _getAllIntrests() => context.read<UsersCubit>().getAllIntrests();

  final Map<String, dynamic> userData = {
    'username': '',
    'password': '',
    'email': '',
    'intrestId': '',
    'image64': null,
  };
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _getAllIntrests();
  }

  void _onCreateUser() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    await context.read<UsersCubit>().insertUser(
          username: userData['username']!,
          password: userData['password']!,
          email: userData['email']!,
          intrestId: userData['intrestId']!,
          imageAsBase64: userData['image64'],
        );
    if (mounted) {
      Navigator.pop(context);
      context.read<NotesCubit>().getAllNotes();
      AppToast.build('User has been Added Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: ((context, state) {
        if (state is AllIntrestsIsLoading) {
          return const AppLoader();
        } else if (state is AllIntrestsLoadedError) {
          return const Text('Error');
        } else if (state is AllIntrestsLoadedSuccess) {
          final intrests = state.intrest
              .map((Intrest user) => user.intrestText.toString())
              .toList();
          String dropdownValue = intrests.first;
          var cubit = context.read<UsersCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add User'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: cubit.userImage == null
                            ? const AssetImage(AppImages.user)
                            : FileImage(cubit.userImage!) as ImageProvider,
                        radius: 50,
                      ),
                      TextButton(
                        onPressed: () async {
                          userData['image64'] = await cubit.openImage();
                        },
                        child: const Text('Select Image'),
                      ),
                      DefaultTextFormField(
                        label: 'User Name',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must Enter User Name.';
                          }
                        },
                        onSave: (value) {
                          userData['username'] = value;
                        },
                      ),
                      const SizedBox(height: 25),
                      DefaultTextFormField(
                        label: 'Password',
                        isPassword: true,
                        validator: (value) {
                          RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])");
                          if (passValid.hasMatch(value) == false) {
                            return 'Password should have alphabet and numbers.';
                          } else if (value.isEmpty || value.length < 8) {
                            return 'Password should have minimum length 8.';
                          }
                        },
                        onSave: (value) {
                          userData['password'] = value;
                        },
                      ),
                      const SizedBox(height: 25),
                      DefaultTextFormField(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!EmailValidator.validate(value)) {
                            return 'Incorrect Email';
                          }
                        },
                        onSave: (value) {
                          userData['email'] = value;
                        },
                      ),
                      const SizedBox(height: 25),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Interest',
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
                          final intrest = state.intrest.firstWhere(
                              (element) => element.intrestText == newValue);
                          userData['intrestId'] = intrest.id;
                        },
                        items: intrests
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          _onCreateUser();
                        },
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
