import 'package:flutter/material.dart';
import 'package:notelite/services/database/note_database.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }


  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: contentController,
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                context.read<NoteDatabase>().create(contentController.text);

                contentController.clear();

                Navigator.pop(context);
              },
              child: const Text('Create 🌠'),
            ),
          ],
        ),
    );
  }

  void updateNote(Note note) {
    contentController.text = note.content;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Update ✏️'),
          content: TextField(
            controller: contentController,
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                context.read<NoteDatabase>().update(note.id, contentController.text);

                contentController.clear();

                Navigator.pop(context);
              },
              child: const Text('Update ✏️'),
            )
          ],
        ),
    );
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().delete(id);
  }

  void readNotes() {
    context.read<NoteDatabase>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    final notesDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = notesDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lite Note 💫'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];

          return ListTile(
            title: Text(note.content),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => updateNote(note),
                  icon: const Icon(Icons.edit),
                ),

                IconButton(
                  onPressed: () => deleteNote(note.id),
                  icon: const Icon(Icons.delete),
                )
              ]
            ),
          );
        },
      ),
    );
  }
}