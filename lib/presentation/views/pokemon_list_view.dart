import 'package:flutter/material.dart';

import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/controllers/pokemon_list_view_controller.dart';
import 'package:pokedex/presentation/controllers/favorited_pokemon_list_view_controller.dart';
import 'package:pokedex/presentation/views/pokemon_data_view.dart';
import 'package:pokedex/presentation/widgets/pokemon_list_tile.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({Key? key}) : super(key: key);

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  List<PokemonEntity> favoritedsPokemon = [];

  @override
  void initState() {
    super.initState();
    favoritedsPokemon = FavoritedPokemonListViewController.favoritedPokemonList.value;
    if (PokemonListViewController.isLoadingList == false) PokemonListViewController.getPokemonList(155);
  }

  void printPokemon(PokemonEntity pokemon) async {
    print(pokemon.id);
    print(pokemon.name);
    for (TypeEntity type in pokemon.types) {
      print(type.name);
      print(type.primaryColor);
      print(type.secondaryColor);
      print(type.tertiaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: ValueListenableBuilder<List<PokemonEntity>>(
            valueListenable: PokemonListViewController.pokemonList,
            builder: (context, pokemonList, _) {
              return ListView.builder(
                itemCount: pokemonList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PokemonDataView(pokemon: pokemonList[index]);
                          },
                        ),
                      );
                    },
                    child: PokemonListTile(
                      pokemon: pokemonList[index],
                      favoritedsPokemon: favoritedsPokemon,
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
