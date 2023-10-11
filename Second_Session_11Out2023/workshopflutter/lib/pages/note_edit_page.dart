import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshopflutter/language/blocs/language_bloc.dart';
import 'package:workshopflutter/language/models/language_model.dart';
import 'package:workshopflutter/main.dart';
import 'package:workshopflutter/note_list/bloc/note_edit_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteEditPage extends StatelessWidget {
  const NoteEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.noteListPage_title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              serviceLocator
                  .get<NoteEditBloc>()
                  .add(const NoteEditEventReset());
              Navigator.pop(context);
            },
          ),
          actions: [
            BlocBuilder<LanguageBloc, LanguageState>(
              bloc: serviceLocator.get<LanguageBloc>(),
              buildWhen: (p, c) =>
                  p.currentLanguage != c.currentLanguage ||
                  p.availableLanguages != c.availableLanguages ||
                  p.status != c.status,
              builder: (context, state) {
                return DropdownButton<LanguageModel>(
                    value: state.currentLanguage,
                    items: state.availableLanguages
                        .map<DropdownMenuItem<LanguageModel>>(
                            (_) => DropdownMenuItem(
                                  value: _,
                                  child: Text(_.languageName),
                                ))
                        .toList(),
                    onChanged: (languageModel) {
                      serviceLocator.get<LanguageBloc>().add(
                          LanguageEventLanguageChanged(lang: languageModel));
                    });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            serviceLocator
                .get<NoteEditBloc>()
                .add(const NoteEditEventSaveNote());
            Navigator.pop(context);
          },
          tooltip: AppLocalizations.of(context)!.noteListPage_save,
          child: const Icon(Icons.save),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.noteEditPage_title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const _TitleInput(),
            const _ContentInput(),
          ],
        ));
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteEditBloc, NoteEditState>(
        bloc: serviceLocator.get<NoteEditBloc>(),
        buildWhen: (p, c) => p.updatedTitle != c.updatedTitle,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.updatedTitle,
            onChanged: (updatedText) => serviceLocator
                .get<NoteEditBloc>()
                .add(NoteEditEventUpdateTitleNote(title: updatedText)),
          );
        });
  }
}

class _ContentInput extends StatelessWidget {
  const _ContentInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteEditBloc, NoteEditState>(
        bloc: serviceLocator.get<NoteEditBloc>(),
        buildWhen: (p, c) => p.updatedContent != c.updatedContent,
        builder: (context, state) {
          return TextFormField(
            initialValue: state.updatedContent,
            maxLines: 5,
            onChanged: (updatedText) => serviceLocator
                .get<NoteEditBloc>()
                .add(NoteEditEventUpdateContentNote(content: updatedText)),
          );
        });
  }
}
