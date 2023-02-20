import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/features/manage_note/presentation/cubit/notes_cubit.dart';
import 'package:notes/features/manage_note/presentation/cubit/options_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
      ),
      body: ListTile(
        title: Text(
          'Use Local Database',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18.sp,
          ),
        ),
        subtitle: Text(
          'Use Local Database',
          style: TextStyle(
            color: AppColors.secondryColor,
            fontSize: 16.sp,
          ),
        ),
        trailing: BlocBuilder<OptionsCubit, OptionsState>(
          builder: (context, state) {
            var optionsCubit = context.read<OptionsCubit>();
            return Switch(
              value: optionsCubit.isLocalEnabled,
              onChanged: (value) {
                optionsCubit.changeLocalEnabled(value);
                context.read<NotesCubit>().getAllNotes();
              },
            );
          },
        ),
      ),
    );
  }
}
