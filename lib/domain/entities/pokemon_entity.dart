import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'dart:convert';

class PokemonEntity {
  final String name;
  final int id;
  final String spriteUrl;
  final String oficialArtWorkUrl;
  List<TypeEntity> types = [];
  final String flavorText;

  PokemonEntity({
    required this.name,
    required this.id,
    required this.types,
    required this.spriteUrl,
    required this.oficialArtWorkUrl,
    required this.flavorText,
  });

  static PokemonEntity fromJson(Map<String, dynamic> json, Map<String, dynamic> json2, {required int id}) {
    List<TypeEntity> getTypes(pokemonData) {
      List<TypeEntity> types = [];
      for (int i = 0; i < pokemonData['types'].length; i++) {
        String pokemonType = pokemonData['types'][i]['type']['name'];
        TypeEntity type = TypeEntityMapper.getPokemonTypeFromMap(pokemonType);
        types.add(type);
      }
      return types;
    }

    String getEnglishText(data) {
      for (int i = 0; i <= 10; i++) {
        if (data['flavor_text_entries'][i]['language']['name'] == "en") {
          return data['flavor_text_entries'][i]['flavor_text'];
        }
      }
      return 'No English Information Found';
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
      flavorText: getEnglishText(json2),
    );
  }

  Map toJson() => {
        '"name"': json.encode(name),
        '"id"': jsonEncode(id),
        '"spriteUrl"': jsonEncode(spriteUrl),
        '"oficialArtWorkUrl"': jsonEncode(oficialArtWorkUrl),
        '"flavorText"': jsonEncode(flavorText),
        '"types"': jsonEncode(types.map((e) => e.toJson()).toList())
      };
}
