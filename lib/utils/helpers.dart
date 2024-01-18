import 'dart:math';

import '../models/characters/character_model.dart';

String? convertWand({
  required Map<String, dynamic> data,
}) {
  String wand = '';

  data.forEach((key, value) {
    if (value is String) {
      if (value.isNotEmpty) {
        wand = '$wand\n$key: $value';
      }
    } else {
      if (value != null) {
        wand = '$wand\n$key: $value';
      }
    }
  });

  final String result = wand.trim();

  if (result.isNotEmpty) {
    return result;
  }

  return null;
}

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
