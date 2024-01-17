import 'dart:math';

import '../models/characters/character_model.dart';

CharacterModel randomCharacter({
  required List<CharacterModel> characters,
}) {
  CharacterModel? character;

  while (character == null) {
    final int index = randomNumber(
      characters.length,
    );

    final CharacterModel temp = characters[index];

    if (temp.isSuccess == null) {
      character = temp;
    }
  }

  return character;
}

int randomNumber(int max) {
  final DateTime now = DateTime.now();
  final Random random = Random(now.millisecondsSinceEpoch);

  return random.nextInt(max);
}
