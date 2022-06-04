import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/data/gateways/core_gateway.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/controllers/types_view_controller.dart';
import 'package:pokedex/presentation/widgets/primary_type_tag.dart';
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
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  height: Scale.width(140),
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
                        height: Scale.width(120),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: TypesViewController.isTypeInformationLoaded,
                          builder: (context, isTypeInformationLoaded, _) {
                            if (isTypeInformationLoaded == false) {
                              return Center(child: CircularProgressIndicator());
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
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
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
