import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/domain/entities/evolution_chain_entity.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/controllers/pokemon_data_view_controller.dart';
import 'package:pokedex/presentation/widgets/evolution_card.dart';

class EvolutionCardsRow extends StatelessWidget {
  final PokemonEntity pokemon;
  final EvolutionChainEntity evolutionChain;
  final int index;

  const EvolutionCardsRow({
    Key? key,
    required this.pokemon,
    required this.evolutionChain,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Scale.width(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EvolutionCard(pokemon: pokemon, envolveCard: evolutionChain.initialPokemon),
          if (index < PokemonDataViewController.evolutionChain.primaryEvolution!.length)
            Padding(
              padding: EdgeInsets.only(left: Scale.width(2)),
              child: EvolutionCard(pokemon: pokemon, envolveCard: evolutionChain.primaryEvolution![index]),
            )
          else
            Padding(
              padding: EdgeInsets.only(left: Scale.width(2)),
              child: EvolutionCard(pokemon: pokemon, envolveCard: evolutionChain.primaryEvolution!.last),
            ),
          PokemonDataViewController.evolutionChain.secondaryEvolution!.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(left: Scale.width(2)),
                  child: EvolutionCard(pokemon: pokemon, envolveCard: evolutionChain.secondaryEvolution![index]),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
