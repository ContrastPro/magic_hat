import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/animations/fade_in_animation.dart';
import '../../../widgets/loaders/custom_loader.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/uncategorized/score_grid.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({super.key});

  static const routeName = '/characters_pages/characters_list';

  @override
  State<CharactersListPage> createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  void _resetQuiz() {
    context.read<QuizBloc>().add(
          const RestartQuiz(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List Screen',
        action: const Text(
          'Reset',
        ),
        onAction: _resetQuiz,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (_, state) {
          if (state.status == BlocStatus.success) {
            return FadeInAnimation(
              duration: kFadeInDuration,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  children: [
                    ScoreGrid(
                      successAttempts: state.successAttempts,
                      failedAttempts: state.failedAttempts,
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CustomLoader(),
          );
        },
      ),
    );
  }
}
