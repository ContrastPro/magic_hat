import 'package:flutter/material.dart';

import '../../../models/characters/character_model.dart';
import '../../../resources/app_images.dart';
import '../../../widgets/loaders/cached_network_image_loader.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import 'widgets/characters_info_bio_item.dart';

class CharactersInfoPage extends StatelessWidget {
  const CharactersInfoPage({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  static const routeName = '/characters_pages/characters_info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: character.name,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        children: [
          Column(
            children: [
              SizedBox(
                width: 144.0,
                height: 200.0,
                child: CachedNetworkImageLoader(
                  imageUrl: character.image,
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              if (character.isSuccess == true) ...[
                CharactersInfoBioItem(
                  title: 'Name',
                  description: character.name,
                ),
                if (character.alternateNames != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Alternate names',
                    description: character.alternateNames!,
                  ),
                ],
                const SizedBox(
                  height: 12.0,
                ),
                CharactersInfoBioItem(
                  title: 'Species',
                  description: character.species,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                CharactersInfoBioItem(
                  title: 'Gender',
                  description: character.gender,
                ),
                if (character.house != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'House',
                    description: character.house!,
                  ),
                ],
                if (character.dateOfBirth != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Date of Birth',
                    description: character.dateOfBirth!,
                  ),
                ],
                const SizedBox(
                  height: 12.0,
                ),
                CharactersInfoBioItem(
                  title: 'Is Wizard',
                  description: '${character.wizard}',
                ),
                if (character.ancestry != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Ancestry',
                    description: character.ancestry!,
                  ),
                ],
                if (character.eyeColour != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Eye colour',
                    description: character.eyeColour!,
                  ),
                ],
                if (character.hairColour != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Hair colour',
                    description: character.hairColour!,
                  ),
                ],
                if (character.wand != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Wand',
                    description: character.wand!,
                  ),
                ],
                if (character.patronus != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Patronus',
                    description: character.patronus!,
                  ),
                ],
                const SizedBox(
                  height: 12.0,
                ),
                CharactersInfoBioItem(
                  title: 'Is Hogwarts student',
                  description: '${character.hogwartsStudent}',
                ),
                const SizedBox(
                  height: 12.0,
                ),
                CharactersInfoBioItem(
                  title: 'Is Hogwarts staff',
                  description: '${character.hogwartsStaff}',
                ),
                if (character.actor != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Actor',
                    description: character.actor!,
                  ),
                ],
                if (character.alternateActors != null) ...[
                  const SizedBox(
                    height: 12.0,
                  ),
                  CharactersInfoBioItem(
                    title: 'Alternate actors',
                    description: character.alternateActors!,
                  ),
                ],
                const SizedBox(
                  height: 12.0,
                ),
                CharactersInfoBioItem(
                  title: 'Is alive',
                  description: '${character.alive}',
                ),
              ] else ...[
                Image.asset(
                  AppImages.topSecret,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
