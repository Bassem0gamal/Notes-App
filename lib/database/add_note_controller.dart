import 'package:note_app/database/sqldb.dart';

class AddNoteController {
  SqlDb sqlDb = SqlDb();

  Future<AddNoteController> add(
      {required String? note, required String? title}) async {
    int response = await sqlDb.insertData('''
                        INSERT INTO notes ("note" , "title")
                        VALUES (
                          "$note" ,
                          "$title"
                                )
                        ''');

    if (response != 0) {
      print(response);
    } else {
      print('Failed to add new note!');
    }
    return AddNoteController();
    //return add(note: note, title: title);
  }
}
