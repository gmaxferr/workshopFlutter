import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:workshopflutter/language/models/language_model.dart';

part 'language_event.dart';
part 'language_state.dart';

enum LanguageStatus { unitialized, loading, success, error }

@Singleton()
class LanguageBloc extends Bloc<LanguageEvent, LanguageState>
    implements Disposable {
  LanguageBloc() : super(const LanguageState()) {
    on<LanguageEventLanguageChanged>(_mapLanguageChangedToState);
    on<LanguageEventGetAvailableLanguages>(_mapGetAvailableLanguagesToState);

    add(const LanguageEventGetAvailableLanguages());
  }

  FutureOr<void> _mapGetAvailableLanguagesToState(
      LanguageEventGetAvailableLanguages event,
      Emitter<LanguageState> emit) async {
    if (state.availableLanguages.isNotEmpty) return;
    // Available flags: https://www.iso.org/obp/ui/#search/code/
    // We should use 2 code of a country
    var en = const LanguageModel(
        languageName: 'English', languageCode: 'en', countryCode: 'gb');
    var pt = const LanguageModel(
        languageName: 'Português', languageCode: 'pt', countryCode: 'pt');

    emit(state.copyWith(
      availableLanguages: [pt, en],
      currentLanguage: en,
    ));
  }

  FutureOr<void> _mapLanguageChangedToState(
      LanguageEventLanguageChanged event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(currentLanguage: event.lang));
  }

  @override
  FutureOr onDispose() {
    close();
  }
}
