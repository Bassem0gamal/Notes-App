import 'package:flutter/material.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/screens/edit_note_screen.dart';
import 'package:note_app/database/sqldb.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT* FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('My Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyNotes.id);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // MaterialButton(
          //   onPressed: () async {
          //     await sqlDb.deleteDataBase();
          //   },
          //   child: const Text('delete database'),
          // ),
          ListView.builder(
              itemCount: notes.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        title: Text('${notes[index]['title']}'),
                        subtitle: Text('${notes[index]['note']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNote(
                                          note: notes[index]['note'],
                                          title: notes[index]['title'],
                                          id: notes[index]['id'],
                                        )));
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                int response = await sqlDb.deleteData(
                                    "DELETE FROM notes WHERE id = ${notes[index]['id']}");
                                if (response > 0) {
                                  notes.removeWhere((element) =>
                                      element['id'] == notes[index]['id']);
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        )));
              }),
        ],
      ),
    );
  }
}
