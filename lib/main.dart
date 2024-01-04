import 'package:flutter/material.dart';
import 'package:notelite/pages/notes_page.dart';
import 'package:notelite/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:notelite/services/database/note_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteDatabase(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
