import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/note.dart';

class NoteDatabase {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> notes = [];

  Future<void> create(String content) async {
    final newNote = Note()..content = content;

    await isar.writeTxn(()  => isar.notes.put(newNote));
  }

  Future<void> update(int id, String content) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.content = content;
      await isar.writeTxn(()  => isar.notes.put(existingNote));
    }
  }

  Future<void> delete(int id) async {
    await isar.writeTxn(()  => isar.notes.delete(id));
  }

  Future<List<Note>> getAll() async {
    final notes = await isar.notes.where().findAll();
    return notes;
  }
}