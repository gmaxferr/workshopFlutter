import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshopflutter/note_list/models/note.dart';

abstract interface class NoteListStorage {
  Future<void> saveNote(Note note);
  Future<List<Note>> loadNotes();
  Future<void> deleteNote(String noteId);
}

@Injectable(as: NoteListStorage)
class NoteListStorageSharedPreferences implements NoteListStorage {
  final SharedPreferences shInstance;

  NoteListStorageSharedPreferences({required this.shInstance});

  // {
  //   "<noteId_X>": "<serielized_noteX>",
  //   "<noteId_Y>": "<serielized_noteY>",
  //   "<noteId_Z>": "<serielized_noteZ>"
  // }

  @override
  Future<void> deleteNote(String noteId) async {
    if (shInstance.containsKey(noteId)) {
      await shInstance.remove(noteId);
    }
  }

  @override
  Future<List<Note>> loadNotes() async {
    Set<String> noteIds = shInstance.getKeys();
    final List<Note> toReturn = [];
    for (String id in noteIds) {
      String? serielizedNote = shInstance.getString(id);
      if (serielizedNote == null) continue;
      toReturn.add(Note.deserialize(serielizedNote));
    }

    return toReturn;
  }

  @override

  /// If already exists, will update.
  Future<void> saveNote(Note note) async {
    bool alreadyExists = shInstance.containsKey(note.id);
    if (alreadyExists) {
      await shInstance.remove(note.id);
    }
    await shInstance.setString(note.id, note.serialize());
  }
}
