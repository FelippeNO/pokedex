import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'dart:convert';

class PokemonEntity {
  final String name;
  final int id;
  final String spriteUrl;
  final String oficialArtWorkUrl;
  List<TypeEntity> types = [];

  PokemonEntity({
    required this.name,
    required this.id,
    required this.types,
    required this.spriteUrl,
    required this.oficialArtWorkUrl,
  });

  static PokemonEntity fromJson(Map<String, dynamic> json, {required int id}) {
    List<TypeEntity> getTypes(pokemonData) {
      List<TypeEntity> types = [];
      for (int i = 0; i < pokemonData['types'].length; i++) {
        String pokemonType = pokemonData['types'][i]['type']['name'];
        var type = TypeEntityMapper.getPokemonTypeFromMap(pokemonType);
        types.add(type);
      }
      return types;
    }

    getSpriteFromUrl(int pokemonId) {
      String url = HttpClientBase.basePokemonSpritesUrl + pokemonId.toString() + ".png";
      return url;
    }

    getOficialArtWorkFromUrl(int pokemonId) {
      String url = HttpClientBase.basePokemonOficialArtWorkUrl + pokemonId.toString() + ".png";
      return url;
    }

    return PokemonEntity(
      name: json['name'],
      id: id,
      types: getTypes(json),
      spriteUrl: getSpriteFromUrl(id),
      oficialArtWorkUrl: getOficialArtWorkFromUrl(id),
    );
  }

  Map toJson() => {
        '"name"': json.encode(name),
        '"id"': jsonEncode(id),
        '"spriteUrl"': jsonEncode(spriteUrl),
        '"oficialArtWorkUrl"': jsonEncode(oficialArtWorkUrl),
        '"types"': jsonEncode(types.map((e) => e.toJson()).toList())
      };
}
