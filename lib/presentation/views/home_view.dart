import 'package:flutter/material.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/controllers/pokemon_list_view_controller.dart';
import 'package:pokedex/presentation/views/favorited_pokemon_list_view.dart';
import 'package:pokedex/presentation/views/pokemon_search_view.dart';
import 'package:pokedex/presentation/views/pokemon_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    if (PokemonListViewController.isLoadedFavoritedPokemon == false) {
      PokemonListViewController.initialize();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PokemonListView();
                      },
                    ),
                  );
                },
                child: Text("pokemon list"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FavoritedPokemonListView();
                      },
                    ),
                  );
                },
                child: Text("favorited pokemon list"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PokemonSearchView();
                      },
                    ),
                  );
                },
                child: Text("pokemon search"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
