part of 'note_edit_bloc.dart';

abstract class NoteEditEvent extends Equatable {
  const NoteEditEvent();
  @override
  List<Object?> get props => [];
}

class NoteEditEventSetNote extends NoteEditEvent {
  final Note editNote;
  const NoteEditEventSetNote({required this.editNote});
  @override
  List<Object?> get props => [editNote];
}

class NoteEditEventUpdateTitleNote extends NoteEditEvent {
  final String title;
  const NoteEditEventUpdateTitleNote({required this.title});
  @override
  List<Object?> get props => [title];
}

class NoteEditEventUpdateContentNote extends NoteEditEvent {
  final String content;
  const NoteEditEventUpdateContentNote({required this.content});
  @override
  List<Object?> get props => [content];
}

class NoteEditEventSaveNote extends NoteEditEvent {
  const NoteEditEventSaveNote();
  @override
  List<Object?> get props => [];
}
class NoteEditEventReset extends NoteEditEvent {
  const NoteEditEventReset();
  @override
  List<Object?> get props => [];
}
