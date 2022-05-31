import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritedPokemonListViewController extends ChangeNotifier {
  static ValueNotifier<List<PokemonEntity>> favoritedPokemonList = ValueNotifier([]);

  static void favoritePokemon(PokemonEntity pokemon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!favoritedPokemonList.value.any((pokemons) => pokemons.id == pokemon.id)) {
      // TODO
      favoritedPokemonList.value.add(pokemon);

      prefs.setString("favoritedPokemon", getListStringPokemon());
      favoritedPokemonList.notifyListeners();
    }
  }

  static void unfavoritePokemon(PokemonEntity pokemon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (favoritedPokemonList.value.any((pokemons) => pokemons.id == pokemon.id)) {
      favoritedPokemonList.value.removeWhere((pokemons) => pokemons.id == pokemon.id);

      prefs.setString("favoritedPokemon", getListStringPokemon());
      favoritedPokemonList.notifyListeners();
    }
  }

  static String getListStringPokemon() {
    List<String> pokemonListString = [];

    for (int i = 0; i < favoritedPokemonList.value.length; i++) {
      String pokemonString = favoritedPokemonList.value[i].toJson().toString();
      pokemonListString.add(pokemonString);
    }
    return pokemonListString.toString();
  }
}
