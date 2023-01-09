import 'package:note_app/database/sqldb.dart';
import 'package:flutter/material.dart';

class EditNoteController {
  SqlDb sqlDb = SqlDb();

  Future<EditNoteController> edit(
      {required String note, required String title, required int id}) async {
    int? response = await sqlDb.updateData('''
                        UPDATE notes SET
                        note = "$note" ,
                        title =  "$title" ,
                        WHERE id = "$id",

                        ''');

    if (response != 0) {
      print(response);
    } else {
      print('Failed to edit the note!');
    }
    return EditNoteController();
    //return edit(note: note, title: title, id: id);
  }
}
