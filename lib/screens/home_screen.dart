import 'package:flutter/material.dart';
import 'package:note_app/database/read_data_controller.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/model/delete_button.dart';
import 'package:note_app/model/edit_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  ReadDataController dataController = ReadDataController();
  late List<NoteModel> noteList;

  void readData() async {
    await dataController.readData();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    noteList = dataController.noteList;
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('My Notes'),
        actions: [
          DeleteAllNotes(onDeleteAllNotes: () {
            noteList.clear();
            setState(() {});
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyNotes.id);
          noteList.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          ListView.builder(
            itemCount: noteList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              NoteModel note = noteList[index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.note),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EditButton(note: note),
                      DeleteButton(
                        note: note,
                        onDelete: () {
                          noteList
                              .removeWhere((element) => element.id == note.id);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
