part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class LanguageEventLanguageChanged extends LanguageEvent {
  const LanguageEventLanguageChanged({this.lang});

  final LanguageModel? lang;

  @override
  List<Object?> get props => [lang];
}

class LanguageEventGetAvailableLanguages extends LanguageEvent {
  const LanguageEventGetAvailableLanguages();

  @override
  List<Object?> get props => [];
}
