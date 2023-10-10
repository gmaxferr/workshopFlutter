part of 'note_list_bloc.dart';

abstract class NoteListEvent extends Equatable {
  const NoteListEvent();
  @override
  List<Object?> get props => [];
}

class NoteListEventFetchAll extends NoteListEvent {
  const NoteListEventFetchAll();
  @override
  List<Object?> get props => [];
}

class NoteListEventCreateNote extends NoteListEvent {
  final String title;
  final String content;
  const NoteListEventCreateNote({required this.title, required this.content});
  @override
  List<Object?> get props => [title, content];
}

class NoteListEventUpdateNote extends NoteListEvent {
  final Note updatedNote;
  const NoteListEventUpdateNote({required this.updatedNote});
  @override
  List<Object?> get props => [updatedNote];
}

class NoteListEventDeleteNote extends NoteListEvent {
  final String noteId;
  const NoteListEventDeleteNote({required this.noteId});
  @override
  List<Object?> get props => [noteId];
}