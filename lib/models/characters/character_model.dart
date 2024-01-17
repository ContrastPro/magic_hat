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
    this.alternateNames,
    required this.species,
    required this.gender,
    this.house,
    this.dateOfBirth,
    this.yearOfBirth,
    required this.wizard,
    this.ancestry,
    this.eyeColour,
    this.hairColour,
    this.wand,
    this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    this.actor,
    this.alternateActors,
    required this.alive,
    this.image,
    this.attempts,
    this.isSuccess,
  });

  factory CharacterModel.fromJsonApi(Map<String, dynamic> json) {
    final String alternateNames = jsonEncode(json['alternate_names']);
    final String alternateActors = jsonEncode(json['alternate_actors']);
    final String wand = jsonEncode(json['wand']);

    return CharacterModel(
      id: json['id'],
      name: json['name'],
      alternateNames: alternateNames,
      species: json['species'],
      gender: json['gender'],
      house: (json['house'] as String).isNotEmpty ? json['house'] : null,
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth'],
      wizard: json['wizard'],
      ancestry:
          (json['ancestry'] as String).isNotEmpty ? json['ancestry'] : null,
      eyeColour:
          (json['eyeColour'] as String).isNotEmpty ? json['eyeColour'] : null,
      hairColour:
          (json['hairColour'] as String).isNotEmpty ? json['hairColour'] : null,
      wand: wand,
      patronus:
          (json['patronus'] as String).isNotEmpty ? json['patronus'] : null,
      hogwartsStudent: json['hogwartsStudent'],
      hogwartsStaff: json['hogwartsStaff'],
      actor: (json['actor'] as String).isNotEmpty ? json['actor'] : null,
      alternateActors: alternateActors,
      alive: json['alive'],
      image: (json['image'] as String).isNotEmpty ? json['image'] : null,
    );
  }

  factory CharacterModel.fromJsonDatabase(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      alternateNames: json['alternateNames'],
      species: json['species'],
      gender: json['gender'],
      house: json['house'],
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth'],
      wizard: json['wizard'] == 1 ? true : false,
      ancestry: json['ancestry'],
      eyeColour: json['eyeColour'],
      hairColour: json['hairColour'],
      wand: json['wand'],
      patronus: json['patronus'],
      hogwartsStudent: json['hogwartsStudent'] == 1 ? true : false,
      hogwartsStaff: json['hogwartsStaff'] == 1 ? true : false,
      actor: json['actor'],
      alternateActors: json['alternateActors'],
      alive: json['alive'] == 1 ? true : false,
      image: json['image'],
      attempts: json['attempts'],
      isSuccess: json['isSuccess'] != null
          ? json['isSuccess'] == 1
              ? true
              : false
          : null,
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
  final int? attempts;
  final bool? isSuccess;

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
        'isSuccess': isSuccess != null
            ? isSuccess == true
                ? 1
                : 0
            : null,
      };

  @override
  String toString() {
    return 'CharacterModel{id: $id, name: $name, alternateNames: $alternateNames, species: $species, gender: $gender, house: $house, dateOfBirth: $dateOfBirth, yearOfBirth: $yearOfBirth, wizard: $wizard, ancestry: $ancestry, eyeColour: $eyeColour, hairColour: $hairColour, wand: $wand, patronus: $patronus, hogwartsStudent: $hogwartsStudent, hogwartsStaff: $hogwartsStaff, actor: $actor, alternateActors: $alternateActors, alive: $alive, image: $image, attempts: $attempts, isSuccess: $isSuccess}';
  }
}
