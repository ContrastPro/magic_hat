import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../../models/characters/character_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../widgets/animations/fade_in_animation.dart';
import '../../../widgets/loaders/cached_network_image_loader.dart';
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
  void _restartQuiz() {
    context.read<QuizBloc>().add(
          const RestartQuiz(),
        );
  }

  void _restartCharacter(String characterId) {
    context.read<QuizBloc>().add(
          RestartCharacter(
            characterId: characterId,
          ),
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
        onAction: _restartQuiz,
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (_, state) {
          if (state.status == BlocStatus.success) {
            return FadeInAnimation(
              duration: kFadeInDuration,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: ScoreGrid(
                      successAttempts: state.successAttempts,
                      failedAttempts: state.failedAttempts,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _ChatsContent(
                    characters: sortCharacters(
                      characters: state.characters,
                    ),
                    onRestart: _restartCharacter,
                  ),
                ],
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

class _ChatsContent extends StatelessWidget {
  const _ChatsContent({
    required this.characters,
    required this.onRestart,
  });

  final List<CharacterModel> characters;
  final void Function(String) onRestart;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: characters.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        itemBuilder: (_, int i) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 65.0,
              margin: EdgeInsets.only(
                bottom: i != characters.length - 1 ? 12.0 : 0.0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40.0,
                    height: double.infinity,
                    child: CachedNetworkImageLoader(
                      imageUrl: characters[i].image,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          characters[i].name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          'Attempts: ${characters[i].attempts}',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      if (characters[i].isSuccess == true) ...[
                        const Icon(
                          Icons.task_alt_rounded,
                          color: Colors.green,
                        ),
                      ] else ...[
                        GestureDetector(
                          onTap: () => onRestart(
                            characters[i].id,
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.restart_alt_rounded,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        const Icon(
                          Icons.warning_rounded,
                          color: Colors.red,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
