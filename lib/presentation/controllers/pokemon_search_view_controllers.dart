import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonSearchViewController extends ChangeNotifier {
  static late ValueNotifier<List<PokemonEntity>> pokemonListSEARCHED = ValueNotifier([]);
  static ValueNotifier<TextEditingController> textEditingController = ValueNotifier(TextEditingController());
  static List<int> pokemonIds = [];
  static bool isSearchListLoaded = true;

  static void getPokemonByName(TextEditingController textEditingController) async {
    if (textEditingController.text.length == 0) {
      pokemonListSEARCHED.value = [];
      pokemonIds = [];
      return;
    }
    pokemonListSEARCHED.value = [];
    pokemonIds = [];
    final pokemon = Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=800&offset=0");
    http.Response response = await http.get(pokemon);
    final Map<String, dynamic> pokemonDataJson = json.decode(response.body);

    for (int i = 0; i < 800; i++) {
      final String pokemonName = pokemonDataJson["results"][i]["name"];
      final String pokemonUrl = pokemonDataJson["results"][i]["url"];

      String pokemonIdString = pokemonUrl.split("pokemon/").last.split("/").first;
      int pokemonId = int.parse(pokemonIdString);

      if (pokemonName.contains(textEditingController.text)) {
        if (!pokemonIds.contains(pokemonId)) pokemonIds.add(pokemonId);
      }
    }
    pokemonListSEARCHED.value = [];

    for (int i = 0; i < pokemonIds.length; i++) {
      int pokemonId = pokemonIds[i];
      var result = await CoreGateway.getPokemonData(pokemonId);
      late PokemonEntity pokemon;
      if (result.isRight) {
        pokemon = result.right;
        if ((!pokemonListSEARCHED.value.any((pokemons) => pokemons.id == pokemon.id)) && (pokemon.id == pokemonId)) {
          pokemonListSEARCHED.value.add(pokemon);
          isSearchListLoaded = true;
        }
        pokemonListSEARCHED.notifyListeners();
      } else {
        result.left.printException();
        return;
      }
    }
  }
}
