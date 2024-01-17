part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {
  const QuizEvent();
}

class LoadCharacters extends QuizEvent {
  const LoadCharacters();
}
