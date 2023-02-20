import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/features/manage_note/domain/entities/note.dart';
import 'package:notes/features/manage_note/presentation/cubit/notes_cubit.dart';
import 'package:notes/features/manage_note/presentation/widgets/search_text_field.dart';

import '../screens/update_note_screen.dart';

class NoteBox extends StatefulWidget {
  final List<Note> note;
  const NoteBox({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NoteBox> createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchedList = context.read<NotesCubit>().listNotesSearched;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
                color: AppColors.primaryColor,
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  myFocusNode.requestFocus();
                },
                child: Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              SearchTextField(myFocusNode: myFocusNode),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchedList.isEmpty
                  ? buildListTile(widget.note[index], context)
                  : buildListTile(searchedList[index], context);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount:
                searchedList.isEmpty ? widget.note.length : searchedList.length,
          ),
        )
      ],
    );
  }

  ListTile buildListTile(Note note, BuildContext context) {
    return ListTile(
      title: SizedBox(
        width: 0.4.sw,
        child: Text(
          note.text,
          style: TextStyle(color: AppColors.blackColor, fontSize: 14.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdateNoteScreen(
                        noteModel: note,
                      )),
            );
          },
          child: const Icon(Icons.edit)),
    );
  }
}
