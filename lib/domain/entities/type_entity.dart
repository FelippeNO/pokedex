import 'package:flutter/material.dart';

class TypeEntity {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final List<TypeEntity>? noDamageTo;
  final List<TypeEntity>? halfDamageTo;
  final List<TypeEntity>? doubleDamageTo;
  final List<TypeEntity>? noDamageFrom;
  final List<TypeEntity>? halfDamageFrom;
  final List<TypeEntity>? doubleDamageFrom;

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
    "water": TypeEntityConsts.water,
  };

  static TypeEntity getPokemonTypeFromMap(String type) {
    TypeEntity pokemonType = TypeEntityMapper.typeEntityMapper[type]!;
    return pokemonType;
  }
}

class TypeEntityConsts {
  static TypeEntity bug = TypeEntity(
    name: 'Bug',
    primaryColor: const Color(0xFFa8b820),
    secondaryColor: const Color(0xFFc6d16e),
    tertiaryColor: const Color(0xFFa0c888),
    // halfDamageTo: [
    //   TypeEntityConsts().fighting,
    //   TypeEntityConsts().flying,
    //   TypeEntityConsts.poison,
    //   TypeEntityConsts().ghost,
    //   TypeEntityConsts().steel,
    //   TypeEntityConsts().fire,
    //   TypeEntityConsts().fairy
    // ],
    // doubleDamageTo: [
    //   TypeEntityConsts.grass,
    //   TypeEntityConsts().psychic,
    //   TypeEntityConsts().dark,
    // ],
    // halfDamageFrom: [
    //   TypeEntityConsts().fighting,
    //   TypeEntityConsts().ground,
    //   TypeEntityConsts.grass,
    // ],
    // doubleDamageFrom: [
    //   TypeEntityConsts().flying,
    //   TypeEntityConsts().rock,
    //   TypeEntityConsts().fire,
    // ],
  );
  static TypeEntity dark = TypeEntity(
    name: "Dark",
    primaryColor: const Color(0xFF705848),
    secondaryColor: const Color(0xFF49392f),
    tertiaryColor: const Color(0xFF908888),
    // doubleDamageFrom: [
    //   TypeEntityConsts().fighting,
    //   TypeEntityConsts().bug,
    //   TypeEntityConsts().fairy,
    // ],
    // doubleDamageTo: [
    //   TypeEntityConsts().ghost,
    //   TypeEntityConsts().psychic,
    // ],
    // halfDamageFrom: [
    //   TypeEntityConsts().dark,
    //   TypeEntityConsts().ghost,
    // ],
    // halfDamageTo: [
    //   TypeEntityConsts().fighting,
    //   TypeEntityConsts().dark,
    //   TypeEntityConsts().fairy,
    // ],
    // noDamageFrom: [
    //   TypeEntityConsts().psychic,
    // ],
  );
  static TypeEntity dragon = TypeEntity(
    name: "Dragon",
    primaryColor: const Color(0xFF7038f8),
    secondaryColor: const Color(0xFF4924a1),
    tertiaryColor: const Color(0xFFf87070),
    // doubleDamageFrom: [
    //   TypeEntityConsts().ice,
    //   TypeEntityConsts().dragon,
    //   TypeEntityConsts().fairy,
    // ],
    // doubleDamageTo: [TypeEntityConsts().dragon],
    // halfDamageFrom: [
    //   TypeEntityConsts().fire,
    //   TypeEntityConsts().water,
    //   TypeEntityConsts.grass,
    //   TypeEntityConsts().electric,
    // ],
    // halfDamageTo: [
    //   TypeEntityConsts().steel,
    // ],
    // noDamageTo: [
    //   TypeEntityConsts().fairy,
    // ],
  );
  static TypeEntity electric = TypeEntity(
    name: "Electric",
    primaryColor: const Color(0xFFf8d030),
    secondaryColor: const Color(0xFFa1871f),
    tertiaryColor: const Color(0xFFe0e000),
    // doubleDamageFrom: [ground],
    // doubleDamageTo: [flying, water],
    // halfDamageFrom: [flying, steel, electric],
    // halfDamageTo: [grass, electric],
    // noDamageTo: [ground],
  );
  static TypeEntity fairy = TypeEntity(
    name: "Fairy",
    primaryColor: const Color(0xFFee99ac),
    secondaryColor: const Color(0xFF9b6470),
    tertiaryColor: const Color(0xFFf838a8),
    // doubleDamageFrom: [poison, steel],
    // doubleDamageTo: [fighting, dragon, dark],
    // halfDamageFrom: [fighting, bug, dark],
    // halfDamageTo: [poison, steel, fire],
    // noDamageTo: [dragon],
  );
  static TypeEntity fighting = TypeEntity(
    name: "Fighting",
    primaryColor: const Color(0xFFc03028),
    secondaryColor: const Color(0xFF7d1f1a),
    tertiaryColor: const Color(0xFFf87070),
    // doubleDamageFrom: [flying, psychic, fairy],
    // doubleDamageTo: [normal, rock, steel, ice, dark],
    // halfDamageFrom: [rock, bug, dark],
    // halfDamageTo: [flying, poison, bug, psychic, fairy],
    // noDamageTo: [ghost],
  );
  static TypeEntity fire = TypeEntity(
    name: "Fire",
    primaryColor: const Color(0xFFf08030),
    secondaryColor: const Color(0xFF9c531f),
    tertiaryColor: const Color(0xFFf89030),
    // noDamageFrom: [ground, rock, water],
    // doubleDamageTo: [bug, steel, grass, ice],
    // halfDamageFrom: [bug, steel, fire, grass, ice, fairy],
    // halfDamageTo: [fire, water, rock, dragon],
  );
  static TypeEntity flying = TypeEntity(
    name: "Flying",
    primaryColor: const Color(0xFFa890f0),
    secondaryColor: const Color(0xFF6d5e9c),
    tertiaryColor: const Color(0xFFb8b8a8),
    // doubleDamageFrom: [electric, rock, ice],
    // doubleDamageTo: [fighting, bug, grass],
    // halfDamageFrom: [grass, fighting, bug],
    // halfDamageTo: [electric, steel, rock],
    // noDamageFrom: [ground],
  );
  static TypeEntity ghost = TypeEntity(
    name: "Ghost",
    primaryColor: const Color(0xFF705898),
    secondaryColor: const Color(0xFF493963),
    tertiaryColor: const Color(0xFFa870f8),
    // doubleDamageFrom: [ghost, dark],
    // doubleDamageTo: [ghost, psychic],
    // halfDamageTo: [dark],
    // halfDamageFrom: [poison, bug],
    // noDamageFrom: [normal, fighting],
    // noDamageTo: [normal],
  );
  static TypeEntity grass = TypeEntity(
    name: "Grass",
    primaryColor: const Color(0xFF78c850),
    secondaryColor: const Color(0xFF4e8234),
    tertiaryColor: const Color(0xFF88e178),
    // doubleDamageFrom: [
    //   TypeEntityConsts.flying,
    //   TypeEntityConsts.poison,
    //   TypeEntityConsts.bug,
    //   TypeEntityConsts.fire,
    //   TypeEntityConsts.ice
    // ],
    // doubleDamageTo: [
    //   TypeEntityConsts.ground,
    //   TypeEntityConsts.rock,
    //   TypeEntityConsts.water,
    // ],
    // halfDamageFrom: [
    //   TypeEntityConsts.ground,
    //   TypeEntityConsts.water,
    //   TypeEntityConsts.grass,
    //   TypeEntityConsts.electric
    // ],
    // halfDamageTo: [
    //   TypeEntityConsts.flying,
    //   TypeEntityConsts.poison,
    //   TypeEntityConsts.bug,
    //   TypeEntityConsts.steel,
    //   TypeEntityConsts.fire,
    //   TypeEntityConsts.grass,
    //   TypeEntityConsts.dragon
    // ],
  );
  static TypeEntity ground = TypeEntity(
    name: "Ground",
    primaryColor: const Color(0xFFe0c068),
    secondaryColor: const Color(0xFF927d44),
    tertiaryColor: const Color(0xFFc9a24d),
    // doubleDamageFrom: [water, grass, ice],
    // doubleDamageTo: [poison, rock, steel, fire, electric],
    // halfDamageFrom: [poison, rock],
    // halfDamageTo: [bug, grass],
    // noDamageFrom: [electric],
    // noDamageTo: [flying],
  );
  static TypeEntity ice = TypeEntity(
    name: "Ice",
    primaryColor: const Color(0xFF98d8d8),
    secondaryColor: const Color(0xFF638d8d),
    tertiaryColor: const Color(0xFF30d8d0),
    // doubleDamageFrom: [fighting, rock, steel, fire],
    // doubleDamageTo: [flying, ground, grass, dragon],
    // halfDamageFrom: [ice],
    // halfDamageTo: [steel, fire, water, ice],
  );
  static TypeEntity normal = TypeEntity(
    name: "Normal",
    primaryColor: const Color(0xFF6d6d4e),
    secondaryColor: const Color(0xFFb8b8a8),
    tertiaryColor: const Color(0xFFa8a878),
    // doubleDamageFrom: [fighting],
    // halfDamageTo: [rock, steel],
    // noDamageFrom: [ghost],
    // noDamageTo: [ghost],
  );
  static TypeEntity poison = TypeEntity(
    name: "Poison",
    primaryColor: const Color(0xFFa040a0),
    secondaryColor: const Color(0xFF682a68),
    tertiaryColor: const Color(0xFFe090f8),
    // doubleDamageFrom: [
    //   TypeEntityConsts.ground,
    //   TypeEntityConsts.psychic,
    // ],
    // doubleDamageTo: [
    //   TypeEntityConsts.grass,
    //   TypeEntityConsts.fairy,
    // ],
    // halfDamageFrom: [
    //   TypeEntityConsts.fighting,
    //   TypeEntityConsts.poison,
    //   TypeEntityConsts.bug,
    //   TypeEntityConsts.grass,
    //   TypeEntityConsts.fairy
    // ],
    // halfDamageTo: [
    //   TypeEntityConsts.poison,
    //   TypeEntityConsts.ground,
    //   TypeEntityConsts.rock,
    //   TypeEntityConsts.ghost,
    // ],
    // noDamageTo: [
    //   TypeEntityConsts.steel,
    // ],
  );
  static TypeEntity psychic = TypeEntity(
    name: "Psychic",
    primaryColor: const Color(0xFFf85888),
    secondaryColor: const Color(0xFFa13959),
    tertiaryColor: const Color(0xFFf838a8),
    // doubleDamageFrom: [bug, ghost],
    // doubleDamageTo: [fighting, poison],
    // halfDamageFrom: [fighting, psychic],
    // halfDamageTo: [steel, psychic],
    // noDamageTo: [dark],
  );
  static TypeEntity rock = TypeEntity(
    name: "Rock",
    primaryColor: const Color(0xFFb8a038),
    secondaryColor: const Color(0xFF786824),
    tertiaryColor: const Color(0xFFc8a048),
    // doubleDamageFrom: [fighting, ground, steel, water, grass],
    // doubleDamageTo: [flying, bug, fire, ice],
    // halfDamageFrom: [normal, flying, poison, fire],
    // halfDamageTo: [fighting, ground, steel],
  );
  static TypeEntity shadow = TypeEntity(
    name: "Shadow",
    primaryColor: const Color(0xFF000000),
    secondaryColor: const Color(0xFF000000),
    tertiaryColor: const Color(0xFF000000),
  );
  static TypeEntity steel = TypeEntity(
    name: "Steel",
    primaryColor: const Color(0xFFb8b8d0),
    secondaryColor: const Color(0xFF787887),
    tertiaryColor: const Color(0xFF6c717c),
    // doubleDamageFrom: [fighting, ground, fire],
    // doubleDamageTo: [rock, ice, fairy],
    // halfDamageFrom: [normal, flying, rock, bug, steel, grass, psychic, ice, dragon],
    // halfDamageTo: [steel, fire, water, electric],
    // noDamageFrom: [poison],
  );
  static TypeEntity unknown = TypeEntity(
    name: "Unknown",
    primaryColor: const Color(0xFF68a090),
    secondaryColor: const Color(0xFF44685e),
    tertiaryColor: const Color(0xFF343f3c),
  );
  static TypeEntity water = TypeEntity(
    name: "Water",
    primaryColor: const Color(0xFF6890f0),
    secondaryColor: const Color(0xFF445e9c),
    tertiaryColor: const Color(0xFF6c88b8),
    // doubleDamageFrom: [grass, electric],
    // doubleDamageTo: [ground, rock, fire],
    // halfDamageFrom: [steel, fire, water, ice],
    // halfDamageTo: [water, grass, dragon],
  );
}
