import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/type_entity.dart';

class PrimaryTypeTag extends StatelessWidget {
  final TypeEntity type;
  const PrimaryTypeTag({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: Scale.width(1))],
          borderRadius: BorderRadius.circular(Scale.width(3)),
          color: type.primaryColor,
          border: Border.all(color: type.secondaryColor, width: Scale.width(1)),
        ),
        width: Scale.width(16),
        height: Scale.width(7),
        child: Center(child: UIText(type.name, color: Colors.white, fontSize: AppFontSize.s4)));
  }
}
