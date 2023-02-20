import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/features/manage_note/presentation/cubit/notes_cubit.dart';

class SearchTextField extends StatefulWidget {
  final FocusNode myFocusNode;
  const SearchTextField({
    super.key,
    required this.myFocusNode,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return Expanded(
          child: SizedBox(
            height: 25.h,
            child: TextFormField(
              controller: controller,
              focusNode: widget.myFocusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: AppColors.primaryColor,
                  ),
                ),
                suffixIcon: widget.myFocusNode.hasFocus
                    ? IconButton(
                        onPressed: () {
                          widget.myFocusNode.unfocus();
                          FocusScope.of(context).unfocus();
                          controller.text='';
                          context.read<NotesCubit>().getAllNotes();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 12.sp,
                        ),
                      )
                    : const SizedBox(),
              ),
              maxLines: 1,
              onChanged: (newValue) {
                context.read<NotesCubit>().searchNoteList(newValue);
              },
              // onEditingComplete: () => context.ed<NotesCubit>().listNotesSearched.clear(),
            ),
          ),
        );
      },
    );
  }
}
