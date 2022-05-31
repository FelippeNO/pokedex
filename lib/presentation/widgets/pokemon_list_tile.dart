import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/widgets/favorite_button.dart';
import 'package:pokedex/presentation/widgets/primary_type_tag.dart';

class PokemonListTile extends StatelessWidget {
  final PokemonEntity pokemon;
  final List<PokemonEntity> favoritedsPokemon;
  const PokemonListTile({Key? key, required this.pokemon, required this.favoritedsPokemon}) : super(key: key);

  List<Color> getGradientColors(List<TypeEntity> types) {
    try {
      List<Color> colors = [];

      for (int i = 0; i < types.length; i++) {
        colors.add(types[i].tertiaryColor);
        colors.add(types[i].primaryColor);
        colors.add(types[i].secondaryColor);
      }
      return colors;
    } catch (e) {
      return [Colors.white, Colors.black];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Scale.width(3), vertical: Scale.width(3)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Scale.width(4),
          ),
          gradient: LinearGradient(colors: getGradientColors(pokemon.types)),
        ),
        height: Scale.width(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Scale.width(2)),
              child: _PokemonSpriteBox(pokemon.spriteUrl),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.black.withOpacity(0.2),
                  padding: EdgeInsets.all(Scale.width(2)),
                  child: Row(
                    children: [
                      UIText(
                        "#" + pokemon.id.toString(),
                        isCapitalized: true,
                        color: Colors.white,
                        fontSize: AppFontSize.s2,
                      ),
                      SizedBox(width: Scale.width(1)),
                      UIText(
                        pokemon.name,
                        isCapitalized: true,
                        color: Colors.white,
                        fontSize: AppFontSize.s2,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    PrimaryTypeTag(type: pokemon.types[0]),
                    pokemon.types.length > 1
                        ? Padding(
                            padding: EdgeInsets.only(left: Scale.width(1)),
                            child: PrimaryTypeTag(type: pokemon.types[1]),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            FavoriteButton(pokemon: pokemon, favoritedsPokemon: favoritedsPokemon),
          ],
        ),
      ),
    );
  }
}

class _PokemonSpriteBox extends StatelessWidget {
  final String spriteUrl;
  const _PokemonSpriteBox(
    this.spriteUrl, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Scale.width(3))),
        height: Scale.width(12),
        width: Scale.width(12),
        child: Center(
            child: Image.network(
          spriteUrl,
          fit: BoxFit.cover,
        )));
  }
}
