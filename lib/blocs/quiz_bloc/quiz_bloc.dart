import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../database/local_database.dart';
import '../../models/characters/character_model.dart';
import '../../models/uncategorized/isolate_model.dart';
import '../../repositories/characters_repository.dart';
import '../../services/in_app_notification_service.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required this.localDB,
    required this.charactersRepository,
    required this.isolateToken,
  }) : super(const QuizState()) {
    on<LoadQuizData>((event, emit) async {
      emit(
        state.copyWith(
          status: BlocStatus.loading,
        ),
      );

      final List<CharacterModel> characters = [];

      final List<CharacterModel>? savedCharacters =
          await localDB.getCharacters();

      if (savedCharacters != null) {
        characters.addAll(
          savedCharacters,
        );
      } else {
        final List<CharacterModel>? loadedCharacters = await compute(
          charactersRepository.loadCharacters,
          IsolateModel(
            token: isolateToken,
          ),
        );

        if (loadedCharacters != null) {
          await localDB.saveCharacters(
            characters: loadedCharacters,
          );

          characters.addAll(
            loadedCharacters,
          );
        }
      }

      final CharacterModel character = randomCharacter(
        characters: characters,
      );

      emit(
        state.copyWith(
          status: BlocStatus.loaded,
          character: character,
          characters: characters,
        ),
      );

      final int successAttempts =
          characters.fold(0, (p, e) => e.isSuccess == true ? p + 1 : p);

      final int failedAttempts =
          characters.fold(0, (p, e) => e.isSuccess == false ? p + 1 : p);

      if (characters.isNotEmpty) {
        emit(
          state.copyWith(
            status: BlocStatus.success,
            successAttempts: successAttempts,
            failedAttempts: failedAttempts,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failed,
          ),
        );
      }
    });

    on<RestartQuiz>((event, emit) async {
      emit(
        state.copyWith(
          status: BlocStatus.loading,
        ),
      );

      await localDB.deleteAllHistoryData();

      final List<CharacterModel> characters = [];

      final List<CharacterModel>? loadedCharacters = await compute(
        charactersRepository.loadCharacters,
        IsolateModel(
          token: isolateToken,
        ),
      );

      if (loadedCharacters != null) {
        await localDB.saveCharacters(
          characters: loadedCharacters,
        );

        characters.addAll(
          loadedCharacters,
        );
      }

      final CharacterModel character = randomCharacter(
        characters: characters,
      );

      emit(
        state.copyWith(
          status: BlocStatus.loaded,
          character: character,
          characters: characters,
        ),
      );

      if (characters.isNotEmpty) {
        InAppNotificationService.show(
          title: 'Quiz restarted',
        );

        emit(
          state.copyWith(
            status: BlocStatus.success,
            successAttempts: 0,
            failedAttempts: 0,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BlocStatus.failed,
          ),
        );
      }
    });

    on<RefreshCharacter>((event, emit) async {
      emit(
        state.copyWith(
          status: BlocStatus.loading,
        ),
      );

      final CharacterModel character = randomCharacter(
        characters: state.characters,
      );

      emit(
        state.copyWith(
          status: BlocStatus.loaded,
          character: character,
        ),
      );

      InAppNotificationService.show(
        title: 'Character refreshed',
      );

      emit(
        state.copyWith(
          status: BlocStatus.success,
        ),
      );
    });

    on<SelectCharacter>((event, emit) async {
      //
    });

    on<RestartCharacter>((event, emit) async {
      //
    });
  }

  final LocalDB localDB;
  final CharactersRepository charactersRepository;
  final RootIsolateToken isolateToken;
}
