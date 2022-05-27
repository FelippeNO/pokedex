import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';

class PokemonDataEntity extends PokemonEntity {
  final String flavorText;
  final String oficialArtWorkUrl;
  final List<TypeEntity> types;

  PokemonDataEntity(
      {required this.flavorText,
      required final int id,
      required final String name,
      required final String url,
      required final this.types,
      required final this.oficialArtWorkUrl})
      : super(
          id: id,
          url: url,
          name: name,
        );

  static PokemonDataEntity fromJson(Map<String, dynamic> json,
      {required PokemonEntity pokemon,
      required String flavorText,
      required String oficialArtWorkUrl,
      required List<TypeEntity> types}) {
    return PokemonDataEntity(
      name: pokemon.name,
      id: pokemon.id,
      url: pokemon.url,
      flavorText: flavorText,
      oficialArtWorkUrl: oficialArtWorkUrl,
      types: types,
    );
  }
}
