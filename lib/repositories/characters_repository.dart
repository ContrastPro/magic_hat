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
          .map((e) => CharacterModel.fromJson(e))
          .toList();

      return characters;
    }

    return null;
  }
}
