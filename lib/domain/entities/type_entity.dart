import 'package:flutter/material.dart';

class TypeEntity {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  List<TypeEntity>? noDamageTo;
  List<TypeEntity>? halfDamageTo;
  List<TypeEntity>? doubleDamageTo;
  List<TypeEntity>? noDamageFrom;
  List<TypeEntity>? halfDamageFrom;
  List<TypeEntity>? doubleDamageFrom;

  TypeEntity({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    this.noDamageTo,
    this.halfDamageTo,
    this.doubleDamageTo,
    this.noDamageFrom,
    this.halfDamageFrom,
    this.doubleDamageFrom,
  });

  Map toJson() => {
        'name': name,
        'primaryColor': primaryColor.toString(),
        'secondaryColor': secondaryColor.toString(),
        'tertiaryColor': tertiaryColor.toString(),
      };
}

class TypeEntityMapper {
  static final Map<String, TypeEntity> typeEntityMapper = {
    "bug": TypeEntityConsts.bug,
    "dark": TypeEntityConsts.dark,
    "dragon": TypeEntityConsts.dragon,
    "electric": TypeEntityConsts.electric,
    "fairy": TypeEntityConsts.fairy,
    "fighting": TypeEntityConsts.fighting,
    "fire": TypeEntityConsts.fire,
    "flying": TypeEntityConsts.flying,
    "ghost": TypeEntityConsts.ghost,
    "grass": TypeEntityConsts.grass,
    "ground": TypeEntityConsts.ground,
    "ice": TypeEntityConsts.ice,
    "normal": TypeEntityConsts.normal,
    "poison": TypeEntityConsts.poison,
    "psychic": TypeEntityConsts.psychic,
    "rock": TypeEntityConsts.rock,
    "steel": TypeEntityConsts.steel,
    "unknown": TypeEntityConsts.unknown,
    "water": TypeEntityConsts.water,
  };

  static TypeEntity getPokemonTypeFromMap(String type) {
    TypeEntity pokemonType = TypeEntityMapper.typeEntityMapper[type]!;
    return pokemonType;
  }
}

class TypeEntityConsts {
  static TypeEntity bug = TypeEntity(
    name: 'bug',
    primaryColor: const Color(0xFFa8b820),
    secondaryColor: const Color(0xFFc6d16e),
    tertiaryColor: const Color(0xFFa0c888),
  );
  static TypeEntity dark = TypeEntity(
    name: "dark",
    primaryColor: const Color(0xFF705848),
    secondaryColor: const Color(0xFF49392f),
    tertiaryColor: const Color(0xFF908888),
  );
  static TypeEntity dragon = TypeEntity(
    name: "dragon",
    primaryColor: const Color(0xFF7038f8),
    secondaryColor: const Color(0xFF4924a1),
    tertiaryColor: const Color(0xFFf87070),
  );
  static TypeEntity electric = TypeEntity(
    name: "electric",
    primaryColor: const Color(0xFFf8d030),
    secondaryColor: const Color(0xFFa1871f),
    tertiaryColor: const Color(0xFFe0e000),
  );
  static TypeEntity fairy = TypeEntity(
    name: "fairy",
    primaryColor: const Color(0xFFee99ac),
    secondaryColor: const Color(0xFF9b6470),
    tertiaryColor: const Color(0xFFf838a8),
  );
  static TypeEntity fighting = TypeEntity(
    name: "fighting",
    primaryColor: const Color(0xFFc03028),
    secondaryColor: const Color(0xFF7d1f1a),
    tertiaryColor: const Color(0xFFf87070),
  );
  static TypeEntity fire = TypeEntity(
    name: "fire",
    primaryColor: const Color(0xFFf08030),
    secondaryColor: const Color(0xFF9c531f),
    tertiaryColor: const Color(0xFFf89030),
  );
  static TypeEntity flying = TypeEntity(
    name: "flying",
    primaryColor: const Color(0xFFa890f0),
    secondaryColor: const Color(0xFF6d5e9c),
    tertiaryColor: const Color(0xFFb8b8a8),
  );
  static TypeEntity ghost = TypeEntity(
    name: "ghost",
    primaryColor: const Color(0xFF705898),
    secondaryColor: const Color(0xFF493963),
    tertiaryColor: const Color(0xFFa870f8),
  );
  static TypeEntity grass = TypeEntity(
    name: "grass",
    primaryColor: const Color(0xFF78c850),
    secondaryColor: const Color(0xFF4e8234),
    tertiaryColor: const Color(0xFF88e178),
  );
  static TypeEntity ground = TypeEntity(
    name: "ground",
    primaryColor: const Color(0xFFe0c068),
    secondaryColor: const Color(0xFF927d44),
    tertiaryColor: const Color(0xFFc9a24d),
  );
  static TypeEntity ice = TypeEntity(
    name: "ice",
    primaryColor: const Color(0xFF98d8d8),
    secondaryColor: const Color(0xFF638d8d),
    tertiaryColor: const Color(0xFF30d8d0),
  );
  static TypeEntity normal = TypeEntity(
    name: "normal",
    primaryColor: const Color(0xFF6d6d4e),
    secondaryColor: const Color(0xFFb8b8a8),
    tertiaryColor: const Color(0xFFa8a878),
  );
  static TypeEntity poison = TypeEntity(
    name: "poison",
    primaryColor: const Color(0xFFa040a0),
    secondaryColor: const Color(0xFF682a68),
    tertiaryColor: const Color(0xFFe090f8),
  );
  static TypeEntity psychic = TypeEntity(
    name: "psychic",
    primaryColor: const Color(0xFFf85888),
    secondaryColor: const Color(0xFFa13959),
    tertiaryColor: const Color(0xFFf838a8),
  );
  static TypeEntity rock = TypeEntity(
    name: "rock",
    primaryColor: const Color(0xFFb8a038),
    secondaryColor: const Color(0xFF786824),
    tertiaryColor: const Color(0xFFc8a048),
  );
  static TypeEntity shadow = TypeEntity(
    name: "shadow",
    primaryColor: const Color(0xFF000000),
    secondaryColor: const Color(0xFF000000),
    tertiaryColor: const Color(0xFF000000),
  );
  static TypeEntity steel = TypeEntity(
    name: "steel",
    primaryColor: const Color(0xFFb8b8d0),
    secondaryColor: const Color(0xFF787887),
    tertiaryColor: const Color(0xFF6c717c),
  );
  static TypeEntity unknown = TypeEntity(
    name: "unknown",
    primaryColor: const Color(0xFF68a090),
    secondaryColor: const Color(0xFF44685e),
    tertiaryColor: const Color(0xFF343f3c),
  );
  static TypeEntity water = TypeEntity(
    name: "water",
    primaryColor: const Color(0xFF6890f0),
    secondaryColor: const Color(0xFF445e9c),
    tertiaryColor: const Color(0xFF6c88b8),
  );
}
