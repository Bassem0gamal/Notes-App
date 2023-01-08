import 'package:flutter/material.dart';
import 'package:note_app/home.dart';
import 'package:note_app/sqldb.dart';

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
  TextEditingController color = TextEditingController();

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
                      int response = await sqlDb.insertData('''
                        INSERT INTO notes ("note" , "title" , "color")
                        VALUES (
                          "${note.text}" ,
                          "${title.text}" ,
                          "${color.text}"
                          )
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
