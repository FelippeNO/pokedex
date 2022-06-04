import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'dart:convert';

class PokemonEntity {
  final String name;
  final int id;
  final String spriteUrl;
  final String oficialArtWorkUrl;
  final String flavorText;
  final String genus;
  final String evolutionChainUrl;
  final TypeEntity type1;
  final TypeEntity? type2;

  PokemonEntity({
    required this.name,
    required this.id,
    required this.spriteUrl,
    required this.oficialArtWorkUrl,
    required this.flavorText,
    required this.genus,
    required this.evolutionChainUrl,
    required this.type1,
    this.type2,
  });

  static PokemonEntity fromJson(Map<String, dynamic> json, Map<String, dynamic> json2, {required int id}) {
    String getFlavorEnglishText(data) {
      for (int i = 0; i <= 10; i++) {
        if (data['flavor_text_entries'][i]['language']['name'] == "en") {
          return data['flavor_text_entries'][i]['flavor_text'];
        }
      }
      return 'No English Information Found';
    }

    String getGenusEnglishText(data) {
      for (int i = 0; i <= 10; i++) {
        if (data['genera'][i]['language']['name'] == "en") {
          return data['genera'][i]['genus'];
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
      spriteUrl: getSpriteFromUrl(id),
      oficialArtWorkUrl: getOficialArtWorkFromUrl(id),
      flavorText: getFlavorEnglishText(json2),
      genus: getGenusEnglishText(json2),
      evolutionChainUrl: json2['evolution_chain']['url'],
      type1: TypeEntityMapper.getPokemonTypeFromMap(json['types'][0]['type']['name']),
      type2: json['types'].length > 1 ? TypeEntityMapper.getPokemonTypeFromMap(json['types'][1]['type']['name']) : null,
    );
  }

  Map toJson() => {
        '"name"': json.encode(name),
        '"id"': jsonEncode(id),
        '"spriteUrl"': jsonEncode(spriteUrl),
        '"oficialArtWorkUrl"': jsonEncode(oficialArtWorkUrl),
        '"flavorText"': jsonEncode(flavorText),
        '"evolutionChainUrl"': json.encode(evolutionChainUrl),
        '"type1"': json.encode(type1.toJson()),
        '"type2"': json.encode(type1.toJson()),
      };
}
