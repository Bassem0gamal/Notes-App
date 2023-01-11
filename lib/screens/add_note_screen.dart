import 'package:flutter/material.dart';
import 'package:note_app/database/add_note_controller.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/database/sqldb.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  static String id = 'add_notes';

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> key = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void dispose() {
    note.dispose();
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add Notes'),
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
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'title',
                    ),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: 'note',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: (){
                      AddNoteController().add(note: note.text, title: title.text);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Home()),
                              (route) => false);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('Add Note'),
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


// () async {
// int response = await sqlDb.insertData('''
//                         INSERT INTO notes ("note" , "title")
//                         VALUES (
//                           "${note.text}" ,
//                           "${title.text}"
//                                 )
//                         ''');
//
// print('Response ============');
// print(response);
// if (response > 0) {
// Navigator.of(context).pushAndRemoveUntil(
// MaterialPageRoute(
// builder: (context) => const Home()),
// (route) => false);
// }
// }