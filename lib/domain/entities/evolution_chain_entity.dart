import 'package:pokedex/domain/entities/pokemon_entity.dart';

class EvolutionChainEntity {
  final PokemonEntity initialPokemon;
  final List<PokemonEntity>? primaryEvolution;
  final List<PokemonEntity>? secondaryEvolution;

  EvolutionChainEntity({
    required this.initialPokemon,
    this.primaryEvolution,
    this.secondaryEvolution,
  });
}
