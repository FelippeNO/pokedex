import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/controllers/favorited_pokemon_list_view_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PokemonListViewController extends ChangeNotifier {
  static late ValueNotifier<List<PokemonEntity>> pokemonList = ValueNotifier([]);
  static bool isLoadingList = false;
  static bool isLoadedFavoritedPokemon = false;
  static ValueNotifier<List<PokemonEntity>> listPokemonFromJson = ValueNotifier([]);

  static void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listStringPokemon = prefs.getString("favoritedPokemon");
    if (listStringPokemon != null) {
      getPokemonFavoritedListFromSharedPrefs(listStringPokemon);
    }
  }

  static void getPokemonFavoritedListFromSharedPrefs(String listStringPokemon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listStringPokemon = prefs.getString("favoritedPokemon").toString();

    List<Map> listDecoded = json.decode(listStringPokemon).cast<Map<String, dynamic>>();

    for (int i = 0; i < listDecoded.length; i++) {
      var pokemonId = listDecoded[i]["id"] as int;

      late PokemonEntity pokemon;
      var result = await CoreGateway.getPokemonData(pokemonId);

      if (result.isRight) {
        pokemon = result.right;
        if (!listPokemonFromJson.value.contains(pokemon)) {
          listPokemonFromJson.value.add(pokemon);
        }
        listPokemonFromJson.notifyListeners();
      } else {
        result.left.printException();
        return;
      }
    }

    FavoritedPokemonListViewController.favoritedPokemonList.value = listPokemonFromJson.value;
    isLoadedFavoritedPokemon = true;
  }

  static void getPokemonList(int range) async {
    bool loading = false;

    if (loading == false) {
      isLoadingList = true;
      for (int i = 1; i <= range; i++) {
        var result = await CoreGateway.getPokemonData(i);
        late PokemonEntity pokemon;
        if (result.isRight) {
          pokemon = result.right;
          pokemonList.value.add(pokemon);
          pokemonList.notifyListeners();
        } else {
          result.left.printException();
          return;
        }
      }
      loading = false;
    }
  }
}
