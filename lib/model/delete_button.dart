import 'package:flutter/material.dart';
import 'package:note_app/database/sqldb.dart';

import 'note_model.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    super.key,
    required this.note,
    required this.onDelete,
  });

  final NoteModel note;
  final VoidCallback onDelete;

  final SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () async {
        int response =
            await sqlDb.deleteData("DELETE FROM notes WHERE id = ${note.id}");
        onDelete();
      },
    );
  }
}

class DeleteAllNotes extends StatefulWidget {
  const DeleteAllNotes({super.key, required this.onDeleteAllNotes});

  final VoidCallback onDeleteAllNotes;

  @override
  State<DeleteAllNotes> createState() => _DeleteAllNotesState();
}

class _DeleteAllNotesState extends State<DeleteAllNotes> {
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await sqlDb.deleteData("DELETE FROM notes");
          widget.onDeleteAllNotes();
        },
        icon: const Icon(Icons.folder_delete));
  }
}
