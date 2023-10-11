import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:workshopflutter/note_list/bloc/note_list_bloc.dart';
import 'package:workshopflutter/note_list/models/note.dart';

part 'note_edit_event.dart';
part 'note_edit_state.dart';

enum NoteEditStatus { loaded, loading }

@Singleton()
class NoteEditBloc extends Bloc<NoteEditEvent, NoteEditState> {
  final NoteListBloc noteListBloc;

  NoteEditBloc({required this.noteListBloc})
      : super(NoteEditState(noteToEdit: Note.empty())) {
    on<NoteEditEventSetNote>(_mapNoteEditEventSetNoteToState);
    on<NoteEditEventSaveNote>(_mapNoteEditEventSaveNoteToState);
    on<NoteEditEventUpdateContentNote>(_mapNoteEditEventUpdateContentToState);
    on<NoteEditEventUpdateTitleNote>(_mapNoteEditEventUpdateTitleToState);
    on<NoteEditEventReset>(_mapNoteEditEventResetToState);
  }

  FutureOr<void> _mapNoteEditEventUpdateContentToState(
      NoteEditEventUpdateContentNote event, Emitter<NoteEditState> emit) async {
    emit(state.copyWith(updatedContent: event.content));
  }

  FutureOr<void> _mapNoteEditEventResetToState(
      NoteEditEventReset event, Emitter<NoteEditState> emit) async {
    emit(NoteEditState(noteToEdit: Note.empty()));
  }

  FutureOr<void> _mapNoteEditEventUpdateTitleToState(
      NoteEditEventUpdateTitleNote event, Emitter<NoteEditState> emit) async {
    emit(state.copyWith(updatedTitle: event.title));
  }

  FutureOr<void> _mapNoteEditEventSetNoteToState(
      NoteEditEventSetNote event, Emitter<NoteEditState> emit) async {
    emit(state.copyWith(
      noteToEdit: event.editNote,
      updatedTitle: event.editNote.noteTitle,
      updatedContent: event.editNote.noteContent,
    ));
  }

  FutureOr<void> _mapNoteEditEventSaveNoteToState(
      NoteEditEventSaveNote event, Emitter<NoteEditState> emit) async {
    noteListBloc.add(NoteListEventUpdateNote(
        updatedNote: state.noteToEdit.copyWith(
      lastChangeDate: DateTime.now(),
      noteContent: state.updatedContent,
      noteTitle: state.updatedTitle,
    )));
  }
}
