import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/pokemon_entity.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/controllers/core_controller.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({Key? key}) : super(key: key);

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  //late List<PokemonEntity> pokemonList;

  CoreController coreController = CoreController();

  @override
  void initState() {
    super.initState();
    if (CoreController.isLoadingList == false) CoreController.getPokemonList(800);
    //pokemonList = CoreController.pokemonList.value;
  }

  void printPokemon(PokemonEntity pokemon) async {
    print(pokemon.id);
    print(pokemon.name);
    for (TypeEntity type in pokemon.types!) {
      print(type.name);
      print(type.primaryColor);
      print(type.secondaryColor);
      print(type.tertiaryColor);
    }
  }

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: ValueListenableBuilder<List<PokemonEntity>>(
            valueListenable: CoreController.pokemonList,
            builder: (context, pokemonList, _) {
              return ListView.builder(
                itemCount: pokemonList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: Scale.width(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Scale.width(6)),
                        gradient: LinearGradient(
                          colors: getGradientColors(pokemonList[index].types!),
                        ),
                      ),
                      child: ListTile(
                        leading: Container(
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Scale.width(3))),
                          height: Scale.width(13),
                          width: Scale.width(13),
                          child: Image.network(
                            pokemonList[index].spriteUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: UIText(
                          pokemonList[index].name,
                          isCapitalized: true,
                          color: Colors.black,
                          fontSize: AppFontSize.s1,
                        ),
                        subtitle: UIText("#" + pokemonList[index].id.toString(), color: Colors.black),
                        onTap: () => printPokemon(pokemonList[index]),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
