part of 'quiz_bloc.dart';

@immutable
class QuizState {
  const QuizState({
    this.status = BlocStatus.initial,
    this.characters = const [],
  });

  final BlocStatus status;
  final List<CharacterModel> characters;

  QuizState copyWith({
    BlocStatus? status,
    List<CharacterModel>? characters,
  }) {
    return QuizState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }
}
