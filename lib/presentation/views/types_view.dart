import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/controllers/types_view_controller.dart';
import 'package:pokedex/presentation/widgets/types_tags_box.dart';

class TypesView extends StatefulWidget {
  TypeEntity type;
  TypesView(
    this.type, {
    Key? key,
  }) : super(key: key);

  @override
  State<TypesView> createState() => _TypesViewState();
}

class _TypesViewState extends State<TypesView> {
  @override
  void initState() {
    super.initState();
    TypesViewController.initialize(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.type.primaryColor,
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/icons_types/${widget.type.name}_type_icon.png"),
            ),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(1), Colors.black.withOpacity(0.2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Scale.width(4)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(
                  height: Scale.width(160),
                  width: Scale.width(100),
                  decoration: BoxDecoration(
                    color: widget.type.tertiaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      Scale.width(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Scale.width(10), top: Scale.width(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: Scale.width(2)),
                              child: Image.asset("lib/assets/icons_types/${widget.type.name}_type_icon.png",
                                  width: Scale.width(12)),
                            ),
                            UIText(
                              widget.type.name,
                              fontSize: AppFontSize.sh1,
                              textAlign: TextAlign.end,
                              decoration: TextDecoration.none,
                              isCapitalized: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Scale.width(130),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: TypesViewController.isTypeInformationLoaded,
                          builder: (context, isTypeInformationLoaded, _) {
                            if (isTypeInformationLoaded == false) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              return Scrollbar(
                                trackVisibility: true,
                                interactive: true,
                                child: ListView(
                                  children: [
                                    if (widget.type.doubleDamageFrom!.isNotEmpty)
                                      TypesTagsBox(types: widget.type.doubleDamageFrom, relation: "Double Damage From"),
                                    if (widget.type.doubleDamageTo!.isNotEmpty)
                                      TypesTagsBox(types: widget.type.doubleDamageTo, relation: "Double Damage To"),
                                    if (widget.type.halfDamageFrom!.isNotEmpty)
                                      TypesTagsBox(types: widget.type.halfDamageFrom, relation: "Half Damage From"),
                                    if (widget.type.halfDamageTo!.isNotEmpty)
                                      TypesTagsBox(types: widget.type.halfDamageTo, relation: "Half Damage To"),
                                    if (widget.type.noDamageFrom!.isNotEmpty)
                                      TypesTagsBox(types: widget.type.noDamageFrom, relation: "No Damage From"),
                                    if (widget.type.noDamageTo!.isNotEmpty)
                                      TypesTagsBox(types: widget.type.noDamageTo, relation: "No Damage To"),
                                    SizedBox(
                                      height: Scale.width(5),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      PrimaryButton(
                        notSelectedText: "Pokemon Type List",
                        isSelectedController: TypesViewController.isButtonSelected,
                        selectedText: "Pokemon Type List",
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ListOfPokemonTypes(type: widget.type);
                          },
                        ),
                      )
                    ],
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

class ListOfPokemonTypes extends StatefulWidget {
  final TypeEntity type;
  const ListOfPokemonTypes({Key? key, required this.type}) : super(key: key);

  @override
  State<ListOfPokemonTypes> createState() => _ListOfPokemonTypesState();
}

class _ListOfPokemonTypesState extends State<ListOfPokemonTypes> {
  @override
  void dispose() async {
    super.dispose();
    await Future.delayed(const Duration(milliseconds: 10));
    TypesViewController.isButtonSelected.value = TypesViewController.isButtonSelected.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Scale.width(130),
        width: Scale.width(80),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Scale.width(8)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: Scale.width(150),
                  width: Scale.width(80),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                      Scale.width(8),
                    ),
                  ),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: TypesViewController.isTypeListPokemonLoaded,
                    builder: (context, value, _) {
                      if (value == true) {
                        return ListView.builder(
                          itemCount: TypesViewController.typePokemon.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: widget.type.primaryColor.withOpacity(0.4),
                                      border: Border.symmetric(
                                        horizontal: BorderSide(
                                          color: widget.type.primaryColor.withOpacity(0.2),
                                          width: Scale.width(0.2),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Image.network(TypesViewController.typePokemon.value[index].spriteUrl),
                                          height: Scale.width(10),
                                        ),
                                        UIText(TypesViewController.typePokemon.value[index].name, isCapitalized: true),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
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

class PrimaryButton extends StatefulWidget {
  ValueNotifier<bool>? isSelectedController;
  ValueNotifier<bool> isSelected = ValueNotifier(false);
  final bool isBlurred;
  final String selectedText;
  final String notSelectedText;
  VoidCallback onTap;
  PrimaryButton({
    Key? key,
    required this.onTap,
    this.isSelectedController,
    required this.selectedText,
    required this.notSelectedText,
    this.isBlurred = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable:
          widget.isSelectedController != null ? widget.isSelectedController as ValueNotifier<bool> : widget.isSelected,
      builder: (context, value, _) {
        return GestureDetector(
          onTap: () {
            widget.onTap();
            if (widget.isSelectedController != null) {
              widget.isSelectedController!.value = !widget.isSelectedController!.value;
            }
            if (widget.isSelectedController == null) widget.isSelected.value = !widget.isSelected.value;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Scale.width(8)),
            child: BackdropFilter(
              filter:
                  widget.isBlurred ? ImageFilter.blur(sigmaX: 10, sigmaY: 10) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (widget.isSelected.value == true || widget.isSelectedController!.value == true)
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    width: (widget.isSelected.value == true || widget.isSelectedController!.value == true)
                        ? Scale.width(0.3)
                        : Scale.width(0.3),
                  ),
                  color: value == false ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    Scale.width(7),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Scale.width(2)),
                  child: UIText(
                    value == false ? widget.notSelectedText : widget.selectedText,
                    fontSize: AppFontSize.s4,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
