import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshopflutter/language/blocs/language_bloc.dart';
import 'package:workshopflutter/pages/note_list_page.dart';
import 'main.config.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // SharedPreferences.getInstance().then((value) => value.clear());
  runApp(const MyApp());
}

final GetIt serviceLocator = GetIt.instance;

@module
abstract class RegisterModule {
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
}

@InjectableInit(
  initializerName: 'init',
)
Future<void> configureDependencies() async {
  serviceLocator.init();
  await serviceLocator.allReady();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
        bloc: serviceLocator.get<LanguageBloc>(),
        buildWhen: (p, c) =>
            p.availableLanguages != c.availableLanguages ||
            p.currentLanguage != c.currentLanguage ||
            p.status != c.status,
        builder: (context, state) {
          final Locale locale = Locale(state.currentLanguage!.languageCode,
              state.currentLanguage!.countryCode);

          return MaterialApp(
            title: 'Notes App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const NoteListPage(),
          );
        });
  }
}
