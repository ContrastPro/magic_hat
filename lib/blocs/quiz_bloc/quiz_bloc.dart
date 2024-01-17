import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../database/local_database.dart';
import '../../models/characters/character_model.dart';
import '../../models/uncategorized/isolate_model.dart';
import '../../repositories/characters_repository.dart';
import '../../utils/constants.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required this.localDB,
    required this.charactersRepository,
    required this.isolateToken,
  }) : super(const QuizState()) {
    on<LoadCharacters>((event, emit) async {
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

      emit(
        state.copyWith(
          status: BlocStatus.loaded,
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
            characters: characters,
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
  }

  final LocalDB localDB;
  final CharactersRepository charactersRepository;
  final RootIsolateToken isolateToken;
}
