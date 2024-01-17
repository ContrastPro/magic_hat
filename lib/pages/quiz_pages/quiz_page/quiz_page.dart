import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/animations/fade_in_animation.dart';
import '../../../widgets/loaders/cached_network_image_loader.dart';
import '../../../widgets/loaders/custom_loader.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/uncategorized/score_grid.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  static const routeName = '/';

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void _resetQuiz() {
    context.read<QuizBloc>().add(
          const RestartQuiz(),
        );
  }

  void _refreshCharacter() {
    context.read<QuizBloc>().add(
          const RefreshCharacter(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home Screen',
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
              child: RefreshIndicator(
                onRefresh: () async => _refreshCharacter(),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                  children: [
                    ScoreGrid(
                      successAttempts: state.successAttempts,
                      failedAttempts: state.failedAttempts,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 144.0,
                          height: 200.0,
                          child: CachedNetworkImageLoader(
                            imageUrl: state.character!.image,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          state.character!.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
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
