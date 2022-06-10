import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/presentation/controllers/pokemon_data_view_controller.dart';
import 'package:pokedex/presentation/controllers/types_view_controller.dart';
import 'package:pokedex/presentation/views/types_view.dart';
import 'package:pokedex/presentation/widgets/evolution_card.dart';
import 'package:pokedex/presentation/widgets/evolution_cards_row.dart';
import 'package:pokedex/presentation/widgets/primary_type_tag.dart';
import 'package:pokedex/presentation/widgets/rounded_default_container.dart';

class PokemonDataView extends StatefulWidget {
  final PokemonEntity pokemon;
  const PokemonDataView({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonDataView> createState() => _PokemonDataViewState();
}

class _PokemonDataViewState extends State<PokemonDataView> {
  @override
  void initState() {
    super.initState();
    PokemonDataViewController.initialize(widget.pokemon);
  }

  @override
  void dispose() {
    super.dispose();
  }

  LinearGradient _getLinearGradient() {
    return LinearGradient(
      colors: [
        widget.pokemon.type1.secondaryColor.withOpacity(0.6),
        Colors.white.withOpacity(0.8),
        Colors.white.withOpacity(0.8),
        widget.pokemon.type2 != null
            ? widget.pokemon.type2!.secondaryColor.withOpacity(0.6)
            : widget.pokemon.type1.secondaryColor.withOpacity(0.6)
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
          widget.pokemon.type1.primaryColor,
          widget.pokemon.type2 != null ? widget.pokemon.type2!.primaryColor : widget.pokemon.type1.primaryColor
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: Center(
            child: Container(
              height: Scale.width(150),
              width: Scale.width(85),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: _getLinearGradient(),
                borderRadius: BorderRadius.circular(Scale.width(5)),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(Scale.width(2)),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(Scale.width(5)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: GestureDetector(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AnimatedPokemonInformation(pokemon: widget.pokemon);
                                        },
                                      ),
                                      child: RoundedDefaultContainer(
                                          height: Scale.width(30),
                                          width: Scale.width(30),
                                          child: Image.network(widget.pokemon.oficialArtWorkUrl)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: Scale.width(40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: Scale.width(1)),
                                      child: UIText(
                                        "#" + widget.pokemon.id.toString(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppFontSize.s1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    UIText(
                                      widget.pokemon.name,
                                      color: widget.pokemon.type1.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppFontSize.s1,
                                      textAlign: TextAlign.end,
                                      isCapitalized: true,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Scale.width(40),
                                child: UIText(
                                  widget.pokemon.genus,
                                  color: widget.pokemon.type1.secondaryColor,
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Scale.width(3), right: Scale.width(2), left: Scale.width(2)),
                        child: RoundedDefaultContainer(
                          width: Scale.width(100),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Scale.width(1)),
                                child: UIText(
                                  "Types",
                                  fontSize: AppFontSize.s1,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: Scale.width(2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryTypeTag(
                                      scale: 20,
                                      type: widget.pokemon.type1,
                                    ),
                                    widget.pokemon.type2 != null
                                        ? Padding(
                                            padding: EdgeInsets.only(left: Scale.width(2)),
                                            child: PrimaryTypeTag(
                                              scale: 20,
                                              type: widget.pokemon.type2!,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Scale.width(3), right: Scale.width(2), left: Scale.width(2)),
                        child: RoundedDefaultContainer(
                          width: Scale.width(100),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Scale.width(1)),
                                child: UIText(
                                  "About",
                                  fontSize: AppFontSize.s1,
                                  color: Colors.black,
                                ),
                              ),
                              ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Scale.width(1),
                                        right: Scale.width(2),
                                        left: Scale.width(2),
                                        bottom: Scale.width(2)),
                                    child: UIText(
                                      widget.pokemon.flavorText.replaceAll("\n", " "),
                                      maxLines: 8,
                                      textAlign: TextAlign.center,
                                      fontSize: AppFontSize.s3,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Scale.width(3), right: Scale.width(2), left: Scale.width(2)),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: PokemonDataViewController.isEvolutionChainLoaded,
                          builder: (context, isEvolutionChainLoaded, _) {
                            int biggestLength = 0;
                            if (PokemonDataViewController.evolutionChain.primaryEvolution!.length >
                                PokemonDataViewController.evolutionChain.secondaryEvolution!.length) {
                              biggestLength = PokemonDataViewController.evolutionChain.primaryEvolution!.length;
                            } else {
                              biggestLength = PokemonDataViewController.evolutionChain.secondaryEvolution!.length;
                            }
                            if (isEvolutionChainLoaded == true) {
                              return RoundedDefaultContainer(
                                width: Scale.width(100),
                                child: biggestLength > 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: Scale.width(1)),
                                            child: UIText(
                                              "Evolution Chain",
                                              fontSize: AppFontSize.s1,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: Scale.width(2)),
                                            child: ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: biggestLength,
                                              itemBuilder: (BuildContext context, int index) {
                                                return EvolutionCardsRow(
                                                    pokemon: widget.pokemon,
                                                    evolutionChain: PokemonDataViewController.evolutionChain,
                                                    index: index);
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: EvolutionCard(
                                            envolveCard: PokemonDataViewController.evolutionChain.initialPokemon,
                                            pokemon: widget.pokemon),
                                      ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedPokemonInformation extends StatefulWidget {
  PokemonEntity pokemon;
  AnimatedPokemonInformation({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  State<AnimatedPokemonInformation> createState() => _AnimatedPokemonInformationState();
}

class _AnimatedPokemonInformationState extends State<AnimatedPokemonInformation> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Scale.width(80),
        width: Scale.width(70),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Scale.width(8),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: Scale.width(80),
                  width: Scale.width(70),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                      Scale.width(8),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Scale.width(4),
                      left: Scale.width(8),
                      right: Scale.width(8),
                      bottom: Scale.width(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: Scale.width(50),
                          width: Scale.width(50),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: Scale.width(1),
                            ),
                            borderRadius: BorderRadius.circular(
                              Scale.width(8),
                            ),
                          ),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: PokemonDataViewController.isFrontSelected,
                            builder: (context, value, _) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                child: Image.network(
                                  value == true ? widget.pokemon.frontAnimationUrl : widget.pokemon.backAnimationUrl,
                                  scale: 1,
                                ),
                              );
                            },
                          ),
                        ),
                        PrimaryButton(
                            isBlurred: true,
                            selectedText: "Swap to Back",
                            notSelectedText: "Swap to Front",
                            onTap: () {},
                            isSelectedController: PokemonDataViewController.isFrontSelected),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
