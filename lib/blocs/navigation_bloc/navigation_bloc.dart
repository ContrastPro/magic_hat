import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../pages/quiz_pages/quiz_page/quiz_page.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<NavigateTab>((event, emit) {
      emit(
        state.copyWith(
          status: NavigationStatus.tab,
          currentTab: event.index,
          route: event.route,
        ),
      );
    });
  }
}
