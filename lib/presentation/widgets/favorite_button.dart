import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/controllers/favorited_pokemon_list_view_controller.dart';

class FavoriteButton extends StatelessWidget {
  final PokemonEntity pokemon;
  final List<PokemonEntity> favoritedsPokemon;
  const FavoriteButton({
    Key? key,
    required this.pokemon,
    required this.favoritedsPokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<PokemonEntity>>(
      valueListenable: FavoritedPokemonListViewController.favoritedPokemonList,
      builder: (context, favoritedPokemonList, _) {
        if (!favoritedsPokemon.any((pokemonsss) => pokemonsss.id == pokemon.id)) {
          return GestureDetector(
            onTap: () => FavoritedPokemonListViewController.favoritePokemon(pokemon),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  Scale.width(3),
                ),
              ),
              padding: EdgeInsets.all(Scale.width(2)),
              height: Scale.width(7),
              child: Center(
                child: UIText('favorite', fontSize: AppFontSize.s4),
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => FavoritedPokemonListViewController.unfavoritePokemon(pokemon),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  Scale.width(3),
                ),
              ),
              padding: EdgeInsets.all(Scale.width(2)),
              height: Scale.width(7),
              child: Center(
                child: UIText('unfavorite', fontSize: AppFontSize.s4),
              ),
            ),
          );
        }
      },
    );
  }
}
