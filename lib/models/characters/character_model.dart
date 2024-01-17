import 'dart:convert';

enum CharacterModelFields {
  id,
  name,
  alternateNames,
  species,
  gender,
  house,
  dateOfBirth,
  yearOfBirth,
  wizard,
  ancestry,
  eyeColour,
  hairColour,
  wand,
  patronus,
  hogwartsStudent,
  hogwartsStaff,
  actor,
  alternateActors,
  alive,
  image,
  attempts,
  isSuccess,
}

const String characterModelName = 'CharacterModel';

class CharacterModel {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
    required this.attempts,
    required this.isSuccess,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final String alternateNames = json['alternate_names'] is List
        ? (json['alternate_names'] as List).join(', ')
        : json['alternate_names'];

    final String alternateActors = json['alternate_actors'] is List
        ? (json['alternate_actors'] as List).join(', ')
        : json['alternate_actors'];

    final String wand = jsonEncode(
      json['wand'],
    );

    return CharacterModel(
      id: json['id'],
      name: json['name'],
      alternateNames: alternateNames.isNotEmpty ? alternateNames : null,
      species: json['species'],
      gender: json['gender'],
      house: (json['house'] as String).isNotEmpty ? json['house'] : null,
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth'],
      wizard: json['wizard'] is int
          ? json['wizard'] == 1
              ? true
              : false
          : json['wizard'],
      ancestry:
          (json['ancestry'] as String).isNotEmpty ? json['ancestry'] : null,
      eyeColour:
          (json['eyeColour'] as String).isNotEmpty ? json['eyeColour'] : null,
      hairColour:
          (json['hairColour'] as String).isNotEmpty ? json['hairColour'] : null,
      wand: wand,
      patronus:
          (json['patronus'] as String).isNotEmpty ? json['patronus'] : null,
      hogwartsStudent: json['hogwartsStudent'] is int
          ? json['hogwartsStudent'] == 1
              ? true
              : false
          : json['hogwartsStudent'],
      hogwartsStaff: json['hogwartsStaff'] is int
          ? json['hogwartsStaff'] == 1
              ? true
              : false
          : json['hogwartsStaff'],
      actor: (json['actor'] as String).isNotEmpty ? json['actor'] : null,
      alternateActors: alternateActors.isNotEmpty ? alternateActors : null,
      alive: json['alive'] is int
          ? json['alive'] == 1
              ? true
              : false
          : json['alive'],
      image: (json['image'] as String).isNotEmpty ? json['image'] : null,
      attempts: json['attempts'] ?? 0,
      isSuccess: json['isSuccess'] ?? false,
    );
  }

  final String id;
  final String name;
  final String? alternateNames;
  final String species;
  final String gender;
  final String? house;
  final String? dateOfBirth;
  final int? yearOfBirth;
  final bool wizard;
  final String? ancestry;
  final String? eyeColour;
  final String? hairColour;
  final String? wand;
  final String? patronus;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final String? actor;
  final String? alternateActors;
  final bool alive;
  final String? image;
  final int attempts;
  final bool isSuccess;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'alternateNames': alternateNames,
        'species': species,
        'gender': gender,
        'house': house,
        'dateOfBirth': dateOfBirth,
        'yearOfBirth': yearOfBirth,
        'wizard': wizard == true ? 1 : 0,
        'ancestry': ancestry,
        'eyeColour': eyeColour,
        'hairColour': hairColour,
        'wand': wand,
        'patronus': patronus,
        'hogwartsStudent': hogwartsStudent == true ? 1 : 0,
        'hogwartsStaff': hogwartsStaff == true ? 1 : 0,
        'actor': actor,
        'alternateActors': alternateActors,
        'alive': alive == true ? 1 : 0,
        'image': image,
        'attempts': attempts,
        'isSuccess': isSuccess == true ? 1 : 0,
      };

  @override
  String toString() {
    return 'CharacterModel{id: $id, name: $name, alternateNames: $alternateNames, species: $species, gender: $gender, house: $house, dateOfBirth: $dateOfBirth, yearOfBirth: $yearOfBirth, wizard: $wizard, ancestry: $ancestry, eyeColour: $eyeColour, hairColour: $hairColour, wand: $wand, patronus: $patronus, hogwartsStudent: $hogwartsStudent, hogwartsStaff: $hogwartsStaff, actor: $actor, alternateActors: $alternateActors, alive: $alive, image: $image, attempts: $attempts, isSuccess: $isSuccess}';
  }
}
