import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';

class PokemonDataView extends StatefulWidget {
  final PokemonEntity pokemon;
  const PokemonDataView({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDataView> createState() => _PokemonDataViewState();
}

class _PokemonDataViewState extends State<PokemonDataView> {
  LinearGradient _getLinearGradient() {
    return LinearGradient(
      colors: [
        widget.pokemon.types[0].secondaryColor.withOpacity(0.6),
        Colors.white.withOpacity(0.8),
        Colors.white.withOpacity(0.8),
        widget.pokemon.types.length == 2
            ? widget.pokemon.types[1].secondaryColor.withOpacity(0.6)
            : widget.pokemon.types[0].secondaryColor.withOpacity(0.6)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [
        0.05,
        0.2,
        0.85,
        1,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          widget.pokemon.types[0].primaryColor,
          widget.pokemon.types.length == 2 ? widget.pokemon.types[1].primaryColor : widget.pokemon.types[0].primaryColor
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: Center(
            child: Container(
              height: Scale.width(150),
              width: Scale.width(85),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.network(widget.pokemon.oficialArtWorkUrl),
                  Text(widget.pokemon.name + widget.pokemon.flavorText),
                ],
              ),
              decoration: BoxDecoration(
                gradient: _getLinearGradient(),
                borderRadius: BorderRadius.circular(
                  Scale.width(5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
