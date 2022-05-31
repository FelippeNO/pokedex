import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/controllers/favorited_pokemon_list_view_controller.dart';

class FavoritedPokemonListView extends StatefulWidget {
  const FavoritedPokemonListView({Key? key}) : super(key: key);

  @override
  State<FavoritedPokemonListView> createState() => _FavoritedPokemonListViewState();
}

class _FavoritedPokemonListViewState extends State<FavoritedPokemonListView> {
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
        body: ValueListenableBuilder<List<PokemonEntity>>(
          valueListenable: FavoritedPokemonListViewController.favoritedPokemonList,
          builder: (context, favoritedPokemonList, _) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
              ),
              itemCount: favoritedPokemonList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () => FavoritedPokemonListViewController.unfavoritePokemon(favoritedPokemonList[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Scale.width(10),
                      width: Scale.width(10),
                      decoration: BoxDecoration(
                        color: favoritedPokemonList[index].types[0].tertiaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(Scale.width(5)),
                      ),
                      child: Center(
                        child: Image.network(
                          favoritedPokemonList[index].spriteUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
