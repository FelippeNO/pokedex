import 'package:flutter/material.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';

class TypesViewController extends ChangeNotifier {
  static ValueNotifier<bool> isTypeInformationLoaded = ValueNotifier(false);
  static ValueNotifier<List<int>> typePokemonIds = ValueNotifier([]);
  static ValueNotifier<List<PokemonEntity>> typePokemon = ValueNotifier([]);
  static ValueNotifier<bool> isTypeListPokemonLoaded = ValueNotifier(false);

  static void initialize(TypeEntity type) async {
    isTypeInformationLoaded.value = false;
    await CoreGateway.getTypeInformationByName(type);
    isTypeInformationLoaded.value = true;
    isTypeInformationLoaded.notifyListeners();
    getPokemonTypeList(type);
  }

  static Future getPokemonTypeList(TypeEntity type) async {
    isTypeListPokemonLoaded.value = false;
    typePokemonIds.value = [];
    typePokemon.value = [];
    typePokemonIds.value = await CoreGateway.getPokemonTypeList(type);

    for (int i = 0; i < typePokemonIds.value.length; i++) {
      var result = await CoreGateway.getPokemonData(typePokemonIds.value[i]);
      if (result.isRight) {
        typePokemon.value.add(result.right);
      }
    }
    isTypeListPokemonLoaded.value = true;
    isTypeListPokemonLoaded.notifyListeners();
  }
}
