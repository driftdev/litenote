import 'package:flutter/material.dart';
import 'package:notelite/pages/notes_page.dart';
import 'package:notelite/services/database/note_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}
