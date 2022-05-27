import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';

class CoreController {
  static late ValueNotifier<List<PokemonEntity>> pokemonList = ValueNotifier([]);

  void initialize() {}

  static void getPokemonList() async {
    List<PokemonEntity> result = await CoreGateway.getPokemonList();
    pokemonList.value = result;
  }
}
