import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';

class PokemonDataEntity extends PokemonEntity {
  final String flavorText;

  PokemonDataEntity(
      {required this.flavorText,
      required final int id,
      required final String spriteUrl,
      required final String name,
      required List<TypeEntity>? types,
      required final String oficialArtWorkUrl})
      : super(id: id, name: name, types: types, spriteUrl: spriteUrl, oficialArtWorkUrl: oficialArtWorkUrl);

  static PokemonDataEntity fromJson(json,
      {required PokemonEntity pokemon,
      required String flavorText,
      required String oficialArtWorkUrl,
      required List<TypeEntity> types}) {
    return PokemonDataEntity(
      name: pokemon.name,
      id: pokemon.id,
      spriteUrl: pokemon.spriteUrl,
      flavorText: flavorText,
      oficialArtWorkUrl: oficialArtWorkUrl,
      types: pokemon.types,
    );
  }
}
