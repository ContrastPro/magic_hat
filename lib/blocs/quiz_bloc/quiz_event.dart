part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {
  const QuizEvent();
}

class LoadQuizData extends QuizEvent {
  const LoadQuizData();
}

class RestartQuiz extends QuizEvent {
  const RestartQuiz();
}

class RefreshCharacter extends QuizEvent {
  const RefreshCharacter();
}

class SelectCharacter extends QuizEvent {
  const SelectCharacter();
}

class RestartCharacter extends QuizEvent {
  const RestartCharacter();
}
