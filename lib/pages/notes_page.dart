import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notelite/services/database/note_database.dart';
import 'package:provider/provider.dart';

import '../components/note_tile.dart';
import '../components/shared/drawer.dart';
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
        backgroundColor: Theme.of(context).colorScheme.background,
        content: TextField(
          controller: contentController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
                String text = contentController.text.trim();
                if (text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter some content'),
                    ),
                  );
                  return;
                }
                context.read<NoteDatabase>().create(text);

                contentController.clear();

                Navigator.pop(context);
            },
            child: const Text('Create'),
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
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Update'),
        content: TextField(
          controller: contentController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String text = contentController.text.trim();
              if (text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter some content'),
                  ),
                );
                return;
              }

              context
                  .read<NoteDatabase>()
                  .update(note.id, contentController.text);

              contentController.clear();

              Navigator.pop(context);
            },
            child: const Text('Update'),
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Lite Note",
              style: GoogleFonts.dmSerifText(
                fontSize: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];

                return NoteTile(
                  content: note.content,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
