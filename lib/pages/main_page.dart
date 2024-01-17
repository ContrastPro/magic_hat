import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/navigation_bloc/navigation_bloc.dart';
import '../blocs/quiz_bloc/quiz_bloc.dart';
import '../database/local_database.dart';
import '../repositories/characters_repository.dart';
import '../routes/app_router.dart';
import '../widgets/navigation/custom_bottom_navigation_bar.dart';
import '../widgets/services/will_pop_off.dart';
import 'characters_pages/characters_list_page/characters_list_page.dart';
import 'quiz_pages/quiz_page/quiz_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<String> _pages = [
    QuizPage.routeName,
    CharactersListPage.routeName,
  ];

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static final CharactersRepository _charactersRepository =
      CharactersRepository();

  final RootIsolateToken _isolateToken = RootIsolateToken.instance!;

  Future<bool> _onWillPop() async {
    final bool maybePop = await _navigatorKey.currentState!.maybePop();
    return !maybePop;
  }

  void _onSelectTab(String route) {
    if (_navigatorKey.currentState != null) {
      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        route,
        (_) => false,
      );
    }
  }

  void _onSelect({
    required BuildContext context,
    required int currentIndex,
    required int index,
  }) {
    if (currentIndex != index) {
      context.read<NavigationBloc>().add(
            NavigateTab(
              index: index,
              route: _pages[index],
            ),
          );
    } else {
      _navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharactersRepository>(
          create: (_) => _charactersRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (_) => NavigationBloc(),
          ),
          BlocProvider<QuizBloc>(
            create: (_) => QuizBloc(
              localDB: LocalDB.instance,
              charactersRepository: _charactersRepository,
              isolateToken: _isolateToken,
            )..add(
                const LoadQuizData(),
              ),
          ),
        ],
        child: WillPopOff(
          onWillPop: _onWillPop,
          child: BlocConsumer<NavigationBloc, NavigationState>(
            listener: (_, state) {
              if (state.status == NavigationStatus.tab) {
                _onSelectTab(state.route);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: Navigator(
                  key: _navigatorKey,
                  initialRoute: QuizPage.routeName,
                  onGenerateRoute: AppRouter.generateRoute,
                ),
                bottomNavigationBar: CustomBottomNavigationBar(
                  currentTab: state.currentTab,
                  onSelect: (int index) => _onSelect(
                    context: context,
                    currentIndex: state.currentTab,
                    index: index,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
