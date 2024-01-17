part of 'quiz_bloc.dart';

@immutable
class QuizState {
  const QuizState({
    this.status = BlocStatus.initial,
    this.characters = const [],
    this.successAttempts = 0,
    this.failedAttempts = 0,
  });

  final BlocStatus status;
  final List<CharacterModel> characters;
  final int successAttempts;
  final int failedAttempts;

  QuizState copyWith({
    BlocStatus? status,
    List<CharacterModel>? characters,
    int? successAttempts,
    int? failedAttempts,
  }) {
    return QuizState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      successAttempts: successAttempts ?? this.successAttempts,
      failedAttempts: failedAttempts ?? this.failedAttempts,
    );
  }
}
