import 'package:either_dart/either.dart';
import 'package:pokedex/core/network/http_client_base.dart';
import 'package:pokedex/data/exceptions/core_exceptions.dart';
import 'package:pokedex/domain/entities/evolution_chain_entity.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/domain/entities/type_entity.dart';

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

  static Future<EvolutionChainEntity> getEvolutionChain(PokemonEntity pokemon) async {
    List<PokemonEntity> primaryEvolution = [];
    List<PokemonEntity> secondaryEvolution = [];
    final String pokemonEvolutionChainUrl = pokemon.evolutionChainUrl;

    final evolutionData = Uri.parse(pokemonEvolutionChainUrl);
    http.Response response = await http.get(evolutionData);

    final Map<String, dynamic> pokemonDataJson = json.decode(response.body);

    String pokemonIdString = pokemonDataJson['chain']['species']['url'].split("pokemon-species/").last.split("/").first;
    int pokemonId = int.parse(pokemonIdString);

    var initialPokemon = await CoreGateway.getPokemonData(pokemonId);

    List<dynamic> primaryEvolutionJson = pokemonDataJson['chain']['evolves_to'];

    for (int i = 0; i < primaryEvolutionJson.length; i++) {
      List<dynamic> secondaryEvolutionJson = pokemonDataJson['chain']['evolves_to'][i]['evolves_to'];

      for (int j = 0; j < secondaryEvolutionJson.length; j++) {
        String pokemonEvId2 =
            secondaryEvolutionJson[j]['species']['url'].split("pokemon-species/").last.split("/").first;
        int pokemonIdEv2 = int.parse(pokemonEvId2);
        final pokemonCatched2 = await CoreGateway.getPokemonData(pokemonIdEv2);
        secondaryEvolution.add(pokemonCatched2.right);
      }

      String pokemonEvId = primaryEvolutionJson[i]['species']['url'].split("pokemon-species/").last.split("/").first;
      int pokemonIdEv = int.parse(pokemonEvId);
      final pokemonCatched = await CoreGateway.getPokemonData(pokemonIdEv);
      primaryEvolution.add(pokemonCatched.right);
    }

    return EvolutionChainEntity(
        initialPokemon: initialPokemon.right,
        primaryEvolution: primaryEvolution,
        secondaryEvolution: secondaryEvolution);
  }

  static Future<TypeEntity> getTypeInformationByName(TypeEntity type) async {
    String typeName = type.name;
    String pokemonTypeInformarionUrl = "https://pokeapi.co/api/v2/type/$typeName";
    final typeData = Uri.parse(pokemonTypeInformarionUrl);
    http.Response response = await http.get(typeData);

    final Map<String, dynamic> typeDataJson = json.decode(response.body);

    List<TypeEntity> doubleDamageFrom = [];
    List<TypeEntity> doubleDamageTo = [];
    List<TypeEntity> halfDamageFrom = [];
    List<TypeEntity> halfDamageTo = [];
    List<TypeEntity> noDamageFrom = [];
    List<TypeEntity> noDamageTo = [];

    void _getRelation(String relationType, List<TypeEntity> list) {
      for (int i = 0; i < typeDataJson['damage_relations'][relationType].length; i++) {
        if (TypeEntityMapper.typeEntityMapper.containsKey(typeDataJson['damage_relations'][relationType][i]["name"])) {
          list.add(TypeEntityMapper.getPokemonTypeFromMap(typeDataJson['damage_relations'][relationType][i]['name']));
        }
      }
    }

    _getRelation('double_damage_from', doubleDamageFrom);
    _getRelation('double_damage_to', doubleDamageTo);
    _getRelation('half_damage_from', halfDamageFrom);
    _getRelation('half_damage_to', halfDamageTo);
    _getRelation('no_damage_from', noDamageFrom);
    _getRelation('no_damage_to', noDamageTo);

    type.doubleDamageFrom = doubleDamageFrom;
    type.doubleDamageTo = doubleDamageTo;
    type.halfDamageFrom = halfDamageFrom;
    type.halfDamageTo = halfDamageTo;
    type.noDamageFrom = noDamageFrom;
    type.noDamageTo = noDamageTo;

    return type;
  }

  static Future<List<int>> getPokemonTypeList(TypeEntity type) async {
    List<int> pokemonTypeIdList = [];
    String typeName = type.name;
    String pokemonTypeInformarionUrl = "https://pokeapi.co/api/v2/type/$typeName";

    final typeData = Uri.parse(pokemonTypeInformarionUrl);
    http.Response response = await http.get(typeData);
    final Map<String, dynamic> typeDataJson = json.decode(response.body);

    int pokemonTypeAmount = typeDataJson['pokemon'].length;

    for (int i = 0; i < pokemonTypeAmount; i++) {
      String pokemonUrlToCut = typeDataJson['pokemon'][i]['pokemon']['url'];
      String pokemonIdString = pokemonUrlToCut.split("pokemon/").last.split("/").first;
      int pokemonId = int.parse(pokemonIdString);
      pokemonTypeIdList.add(pokemonId);
    }
    print(pokemonTypeIdList);
    return pokemonTypeIdList;
  }
}
