part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final LanguageModel? currentLanguage;
  final List<LanguageModel> availableLanguages;
  final LanguageStatus status;

  const LanguageState({
    this.currentLanguage,
    this.availableLanguages = const <LanguageModel>[],
    this.status = LanguageStatus.unitialized,
  });

  LanguageState copyWith({
    LanguageModel? currentLanguage,
    List<LanguageModel>? availableLanguages,
    LanguageStatus? status,
  }) {
    return LanguageState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      availableLanguages: availableLanguages ?? this.availableLanguages,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        currentLanguage,
        status,
        availableLanguages,
      ];
}
