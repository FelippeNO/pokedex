import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';

class CoreController extends ChangeNotifier {
  static late ValueNotifier<List<PokemonEntity>> pokemonList = ValueNotifier([]);
  static bool isLoadingList = false;

  void initialize() {}

  static void getPokemonList(int range) async {
    bool loading = false;

    if (loading == false) {
      isLoadingList = true;
      for (int i = 1; i <= range; i++) {
        PokemonEntity pokemon = await CoreGateway.getPokemonData(i);
        pokemonList.value.add(pokemon);
        pokemonList.notifyListeners();
        debugPrint("carregado: $i");
      }
      loading = false;
    }
  }
}
