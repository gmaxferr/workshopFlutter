import 'package:injectable/injectable.dart';
import 'package:workshopflutter/note_list/models/note.dart';
import 'package:workshopflutter/note_list/storage/note_list_storage.dart';


// Repository Pattern
// https://codewithandrea.com/articles/flutter-repository-pattern/
@Singleton()
@Injectable(as: NoteListRepository)
class NoteListRepository {
  final NoteListStorage storageInstance;
  NoteListRepository({required this.storageInstance});

  Future<void> saveNote(Note note) {
    return storageInstance.saveNote(note);
  }

  Future<List<Note>> loadNotes() {
    return storageInstance.loadNotes();
  }

  Future<void> deleteNote(String noteId) {
    return storageInstance.deleteNote(noteId);
  }
}
