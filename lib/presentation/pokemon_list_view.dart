import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:string_extensions/string_extensions.dart';

class PokemonListView extends StatefulWidget {
  PokemonListView({Key? key}) : super(key: key);

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  late List<PokemonEntity> pokemonList;

  CoreController coreController = CoreController();

  @override
  void initState() {
    super.initState();
    CoreController.getPokemonList();
    pokemonList = CoreController.pokemonList.value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: pokemonList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(pokemonList[index].name.toString()),
              subtitle: Text(pokemonList[index].id.toString()),
            );
          },
        ),
      ),
    );
  }
}
