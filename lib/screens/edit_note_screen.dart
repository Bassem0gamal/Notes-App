import 'package:flutter/material.dart';
import 'package:note_app/database/edit_note_controller_screen.dart';
import 'package:note_app/database/sqldb.dart';
import 'package:note_app/model/note_model.dart';

import 'home_screen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    Key? key,
    required this.noteModel,
  }) : super(key: key);

  static String screenId = 'add_notes';
  final NoteModel noteModel;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> key = GlobalKey();

  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    noteController.text = widget.noteModel.note;
    titleController.text = widget.noteModel.title;
    super.initState();
    print('initState ===================');
  }

  @override
  void dispose() {
    noteController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Edit Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'title',
                    ),
                  ),
                  TextFormField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      hintText: 'note',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      EditNoteController().edit(
                          note: noteController.text,
                          title: titleController.text,
                          id: widget.noteModel.id);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Home()),
                          (route) => false);
                      print('Edit Success');
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Edit Note'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
