import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';

import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/controllers/pokemon_list_view_controller.dart';
import 'package:pokedex/presentation/controllers/favorited_pokemon_list_view_controller.dart';
import 'package:pokedex/presentation/controllers/pokemon_search_view_controllers.dart';
import 'package:pokedex/presentation/views/pokemon_data_view.dart';
import 'package:pokedex/presentation/widgets/pokemon_list_tile.dart';

class PokemonSearchView extends StatefulWidget {
  const PokemonSearchView({Key? key}) : super(key: key);

  @override
  State<PokemonSearchView> createState() => _PokemonSearchViewState();
}

class _PokemonSearchViewState extends State<PokemonSearchView> {
  List<PokemonEntity> favoritedsPokemon = [];
  TextEditingController textController = PokemonSearchViewController.textEditingController.value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              height: Scale.width(30),
              child: ValueListenableBuilder<TextEditingController>(
                  valueListenable: PokemonSearchViewController.textEditingController,
                  builder: (context, controller, _) {
                    return TextFormField(
                      onChanged: (value) {
                        if (controller.value.text.isNotEmpty) {
                          PokemonSearchViewController.pokemonListSEARCHED.value = [];
                          PokemonSearchViewController.pokemonIds = [];
                          PokemonSearchViewController.isSearchListLoaded = false;

                          EasyDebounce.debounce("searchPokemon", const Duration(milliseconds: 200),
                              () => PokemonSearchViewController.getPokemonByName(controller));
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      controller: controller,
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Search'),
            ),
            Container(
              height: Scale.width(120),
              child: ValueListenableBuilder<List<PokemonEntity>>(
                valueListenable: PokemonSearchViewController.pokemonListSEARCHED,
                builder: (context, pokemonSearchList, _) {
                  if (PokemonSearchViewController.isSearchListLoaded == true) {
                    return ListView.builder(
                      itemCount: textController.value.text.isEmpty ? 0 : pokemonSearchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PokemonDataView(pokemon: pokemonSearchList[index]);
                                },
                              ),
                            );
                          },
                          child: PokemonListTile(
                            pokemon: pokemonSearchList[index],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: const CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
