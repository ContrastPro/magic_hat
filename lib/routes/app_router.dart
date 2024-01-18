import 'package:flutter/material.dart';

import '../models/characters/character_model.dart';
import '../pages/characters_pages/characters_info_page/characters_info_page.dart';
import '../pages/characters_pages/characters_list_page/characters_list_page.dart';
import '../pages/main_page.dart';
import '../pages/quiz_pages/quiz_page/quiz_page.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      // [START] Characters pages
      case CharactersInfoPage.routeName:
        final CharacterModel args = arguments as CharacterModel;
        builder = (_) => CharactersInfoPage(
              character: args,
            );
        break;

      case CharactersListPage.routeName:
        builder = (_) => const CharactersListPage();
        break;

      // [END] Characters pages

      // [START] Quiz pages

      case QuizPage.routeName:
        builder = (_) => const QuizPage();
        break;

      // [END] Quiz pages

      case MainPage.routeName:
        builder = (_) => const MainPage();
        break;

      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
