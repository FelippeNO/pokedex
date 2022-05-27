import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/domain/entities/pokemon_data_entity.dart';

class CoreGateway {
  static Future<List<TypeEntity>> getTypeList() async {
    const String typeListRoute = "type/";
    final typeListUri = HttpClientBase(typeListRoute).httpClient();
    http.Response response1 = await http.get(typeListUri);
    final typeList = json.decode(response1.body);
    List resultado1 = typeList['results'] as List;
    return resultado1.map<TypeEntity>((json) => TypeEntity.fromJson(json)).toList();
  }

  static Future<List<PokemonEntity>> getPokemonList() async {
    const String pokemonListRoute = "pokemon?limit=901&offset=0";

    final pokemonListUri = HttpClientBase(pokemonListRoute).httpClient();
    http.Response response2 = await http.get(pokemonListUri);
    if (response2.statusCode == 200) {
      final pokemonList = json.decode(response2.body);
      List resultado2 = pokemonList['results'] as List;
      return resultado2
          .map<PokemonEntity>(
            (json) => PokemonEntity.fromJson(json),
          )
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  static String getEnglishText(data) {
    for (int i = 0; i <= 10; i++) {
      if (data['flavor_text_entries'][i]['language']['name'] == "en") {
        return data['flavor_text_entries'][i]['flavor_text'];
      }
    }
    return 'No English Information Found';
  }

  static String getOficialArtWorkUrl(String pokemonIdString) {
    const String baseUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/";
    return (baseUrl + pokemonIdString + ".png");
  }

  static Future<PokemonDataEntity> getPokemonData(PokemonEntity pokemon) async {
    final String pokemonIdString = pokemon.id.toString();

    final pokemonDataUri = HttpClientBase("pokemon-species/" + pokemonIdString).httpClient();
    http.Response response2 = await http.get(pokemonDataUri);

    final pokemonDataJson = json.decode(response2.body);
    final String flavorText = getEnglishText(pokemonDataJson);
    final oficialArtWork = getOficialArtWorkUrl(pokemonIdString);

    List<TypeEntity> types = [];

    final pokemonTypeUri = HttpClientBase("pokemon/" + pokemonIdString).httpClient();
    http.Response response3 = await http.get(pokemonTypeUri);
    final pokemonData2Json = json.decode(response3.body);

    List<String> listOfTypesString = [];
    for (int i = 0; i < pokemonData2Json['types'].length; i++) {
      listOfTypesString.add(pokemonData2Json['types'][i]['type']['name']);
    }

    print(listOfTypesString[0].toString());

    return PokemonDataEntity.fromJson(pokemonDataJson,
        pokemon: pokemon, flavorText: flavorText, oficialArtWorkUrl: oficialArtWork, types: types);
  }
}
