import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/animations/fade_in_animation.dart';
import '../../../widgets/loaders/custom_loader.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state.status == BlocStatus.success) {
            return const FadeInAnimation(
              duration: kFadeInDuration,
              child: Center(
                child: Text('Success'),
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
