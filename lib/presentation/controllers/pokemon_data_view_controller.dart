import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/evolution_chain_entity.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';

class PokemonDataViewController extends ChangeNotifier {
  static late EvolutionChainEntity evolutionChain;
  static ValueNotifier<bool> isEvolutionChainLoaded = ValueNotifier(false);

  static void initialize(PokemonEntity pokemon) async {
    isEvolutionChainLoaded.value = false;
    evolutionChain = await CoreGateway.getEvolutionChain(pokemon);
    isEvolutionChainLoaded.value = true;
    isEvolutionChainLoaded.notifyListeners();
  }
}
