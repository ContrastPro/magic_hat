import 'dart:math';

import '../models/characters/character_model.dart';

CharacterModel randomCharacter({
  required List<CharacterModel> characters,
}) {
  final List<CharacterModel> walid =
      characters.where((e) => e.isSuccess == null).toList();

  final int index = randomNumber(
    walid.length,
  );

  final CharacterModel character = walid[index];

  return character;
}

int randomNumber(int max) {
  final DateTime now = DateTime.now();
  final Random random = Random(now.millisecondsSinceEpoch);

  return random.nextInt(max);
}

List<CharacterModel> sortCharacters({
  required List<CharacterModel> characters,
}) {
  return characters.where((e) => e.isSuccess != null).toList();
}
