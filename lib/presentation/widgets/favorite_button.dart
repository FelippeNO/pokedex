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
        bool dontContain = !favoritedsPokemon.any((pokemonList) => pokemonList.id == pokemon.id);
        return GestureDetector(
          onTap: dontContain
              ? () => FavoritedPokemonListViewController.favoritePokemon(pokemon)
              : () => FavoritedPokemonListViewController.unfavoritePokemon(pokemon),
          child: Container(
            decoration: BoxDecoration(
              color: dontContain ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.2),
              border: Border.all(
                  color: dontContain ? Colors.white.withOpacity(0.3) : Colors.white, width: Scale.width(0.3)),
              borderRadius: BorderRadius.circular(
                Scale.width(5),
              ),
            ),
            padding: EdgeInsets.all(Scale.width(2)),
            height: Scale.width(8),
            child: Center(
              child: dontContain
                  ? UIText('Favorite', fontSize: AppFontSize.s4)
                  : UIText('Unfavorite', fontSize: AppFontSize.s4),
            ),
          ),
        );
      },
    );
  }
}
