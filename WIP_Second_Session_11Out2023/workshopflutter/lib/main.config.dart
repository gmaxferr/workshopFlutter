// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:workshopflutter/language/blocs/language_bloc.dart' as _i3;
import 'package:workshopflutter/main.dart' as _i8;
import 'package:workshopflutter/note_list/bloc/note_list_bloc.dart' as _i7;
import 'package:workshopflutter/note_list/repository/note_list_repository.dart'
    as _i6;
import 'package:workshopflutter/note_list/storage/note_list_storage.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.LanguageBloc>(_i3.LanguageBloc());
    gh.factoryAsync<_i4.SharedPreferences>(() => registerModule.prefs);
    gh.factoryAsync<_i5.NoteListStorage>(() async => _i5.NoteListStorageSQflite(
        shInstance: await getAsync<_i4.SharedPreferences>()));
    gh.singletonAsync<_i6.NoteListRepository>(() async =>
        _i6.NoteListRepository(
            storageInstance: await getAsync<_i5.NoteListStorage>()));
    gh.singletonAsync<_i7.NoteListBloc>(() async =>
        _i7.NoteListBloc(repository: await getAsync<_i6.NoteListRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
