import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/views/pokemon_data_view.dart';

class EvolutionCard extends StatelessWidget {
  final PokemonEntity envolveCard;
  final PokemonEntity pokemon;

  const EvolutionCard({
    Key? key,
    required this.envolveCard,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => envolveCard.id != pokemon.id
          ? {
              //TODO ADD A POP WHEN WE CHANGE PAGE
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDataView(
                    pokemon: envolveCard,
                  ),
                ),
              )
            }
          : {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Scale.width(3)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: envolveCard.name != pokemon.name ? Colors.white.withOpacity(0.3) : pokemon.type1.primaryColor,
                width: Scale.width(0.5),
              ),
              borderRadius: BorderRadius.circular(Scale.width(3)),
              gradient: LinearGradient(
                colors: [
                  envolveCard.type1.primaryColor.withOpacity(0.2),
                  envolveCard.type2 != null
                      ? envolveCard.type2!.primaryColor.withOpacity(0.2)
                      : envolveCard.type1.primaryColor.withOpacity(0.2)
                ],
              ),
            ),
            height: Scale.width(19),
            width: Scale.width(15),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Scale.width(12),
                        child: Image.network(
                          envolveCard.oficialArtWorkUrl,
                        ),
                      ),
                      SizedBox(height: Scale.width(0.3)),
                      UIText(
                        envolveCard.name,
                        fontSize: AppFontSize.s6,
                        color: Colors.black,
                        isCapitalized: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
