import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoreGateway {
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

  static Future<PokemonEntity> getPokemonData(int id) async {
    final String pokemonIdString = id.toString();

    final pokemonDataUri = HttpClientBase("pokemon/" + pokemonIdString).httpClient();
    http.Response response2 = await http.get(pokemonDataUri);

    final pokemonDataJson = json.decode(response2.body);

    return PokemonEntity.fromJson(
      pokemonDataJson,
      id: id,
    );
  }
}
