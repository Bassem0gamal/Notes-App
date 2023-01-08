import 'package:flutter/material.dart';
import 'package:note_app/sqldb.dart';

import 'home.dart';

class EditNote extends StatefulWidget {
  const EditNote(
      {Key? key,
      required this.note,
      required this.title,
      required this.id,
      required this.color})
      : super(key: key);

  static String screenId = 'add_notes';
  final String note;
  final String title;
  final String color;
  final int id;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> key = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override

  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
    print('initState ===================');
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
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: 'note',
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'title',
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      hintText: 'color',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      int response = await sqlDb.updateData('''
                       UPDATE notes SET 
                        note = "${note.text}" ,
                        title = "${title.text}" ,
                        color = "${color.text}"
                       WHERE id = ${widget.id}
                        ''');

                      print('Response ============');
                      print(response);
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                                (route) => false);
                      }
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
