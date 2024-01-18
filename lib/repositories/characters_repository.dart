import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../models/characters/character_model.dart';
import '../models/uncategorized/isolate_model.dart';
import 'base_repository.dart';

class CharactersRepository {
  static final BaseRepository _baseRepository = BaseRepository();
  static final Dio _api = _baseRepository.api;

  Future<List<CharacterModel>?> loadCharacters(
    IsolateModel isolate,
  ) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolate.token);

    final Response response = await _api.get(
      '/characters',
    );

    if (response.statusCode == 200) {
      final List<CharacterModel> characters = (response.data as List)
          .map((e) => CharacterModel.fromJsonApi(e))
          .toList();

      //TODO: use this for tests
      /*return [
        characters[0],
        characters[1],
        characters[2],
        characters[8],
        characters[150],
        characters[200],
        characters[250],
        characters[300],
      ];*/

      return characters;
    }

    return null;
  }
}
