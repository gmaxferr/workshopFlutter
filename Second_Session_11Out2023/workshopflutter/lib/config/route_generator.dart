

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workshopflutter/pages/note_edit_page.dart';
import 'package:workshopflutter/pages/note_list_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String noteList = '/';
  static const String noteEdit = '/edit-note';
}

class RouteGenerator {
  // static Map<String, Widget Function(BuildContext context)> routes = {
  //   AppRoutes.noteList: (_) => const NoteListPage(),
  //   AppRoutes.noteEdit: (_) => const LoginPage(),
  // };
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    Uri? settingsUri;
    if (settings.name != null) {
      settingsUri = Uri.parse(settings.name!);
    }

    switch (settingsUri?.path ?? AppRoutes.noteList) {
      case AppRoutes.noteList:
        return const NoteListPage().transition(settings);
      case AppRoutes.noteEdit:
        return const NoteEditPage().transition(settings);
      default:
        return const NoteListPage().transition(settings);
    }
  }
}

extension Transitions on Widget {
  dynamic transition(settings, {PageTransitionType type = PageTransitionType.rightToLeft}) {
    return PageTransition(child: this, type: type, duration: const Duration(milliseconds: 100), isIos: false, settings: settings);
  }
}
