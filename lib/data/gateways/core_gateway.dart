import 'package:either_dart/either.dart';
import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/data/exceptions/core_exceptions.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoreGateway {
  static Future<Either<CoreException, PokemonEntity>> getPokemonData(int id) async {
    final String pokemonIdString = id.toString();

    final pokemonDataUri = HttpClientBase("pokemon/" + pokemonIdString).httpClient();
    http.Response response = await http.get(pokemonDataUri);

    if (response.statusCode != 200) {
      return Left(CoreException("Pokemon-InitialData not found: Pokemon id = $pokemonIdString"));
    }

    final pokemonEspeciesUri = HttpClientBase("pokemon-species/" + pokemonIdString).httpClient();
    http.Response response2 = await http.get(pokemonEspeciesUri);

    if (response2.statusCode != 200) {
      return Left(CoreException("Pokemon-Specie not found: Pokemon id = $pokemonIdString"));
    }

    final pokemonDataJson = json.decode(response.body);
    final pokemonDataSpeciesJson = json.decode(response2.body);

    if (response2.statusCode == 200) {
      return Right(
        PokemonEntity.fromJson(
          pokemonDataJson,
          pokemonDataSpeciesJson,
          id: id,
        ),
      );
    } else {
      return const Left(CoreException("Pokemon not found"));
    }
  }
}
