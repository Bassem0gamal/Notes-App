import 'package:note_app/database/sqldb.dart';

import '../model/note_model.dart';

class ReadDataController {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List<NoteModel> noteList = [];


  Future<void> readData() async {

    List<Map> response = await sqlDb.readData("SELECT* FROM notes");
    for (var item in response) {
      NoteModel noteModel = NoteModel(
        note: item['note'],
        id: item['id'],
        title: item['title'],
      );
      noteList.add(noteModel);
    }
    isLoading = false;
  }
}
