import 'package:flutter/material.dart';
import 'package:note_app/model/note_model.dart';
import '../screens/edit_note_screen.dart';

class EditButton extends StatefulWidget {
  const EditButton({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.edit,
        color: Colors.blue,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditNoteScreen(
                  noteModel: widget.note,
                )));
      },
    );
  }
}
