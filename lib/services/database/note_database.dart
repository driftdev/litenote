import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> currentNotes = [];

  Future<void> create(String content) async {
    final newNote = Note()..content = content;

    await isar.writeTxn(()  => isar.notes.put(newNote));
    getAll();
  }

  Future<void> update(int id, String content) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.content = content;
      await isar.writeTxn(()  => isar.notes.put(existingNote));
    }
    getAll();
  }

  Future<void> delete(int id) async {
    await isar.writeTxn(()  => isar.notes.delete(id));
    getAll();
  }

  Future<void> getAll() async {
    List<Note> notes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(notes);
    notifyListeners();
  }
}