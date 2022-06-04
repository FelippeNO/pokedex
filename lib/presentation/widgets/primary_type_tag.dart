import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/views/types_view.dart';

class PrimaryTypeTag extends StatelessWidget {
  final TypeEntity? type;
  final double scale;
  final bool isClickable;
  const PrimaryTypeTag({
    Key? key,
    required this.type,
    this.scale = 16,
    this.isClickable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClickable
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TypesView(type!),
                ),
              )
          : null,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: Scale.width(1))],
          borderRadius: BorderRadius.circular(Scale.width(3)),
          color: type?.primaryColor,
          border: Border.all(color: type!.secondaryColor, width: Scale.width(1)),
        ),
        width: Scale.width(scale),
        height: Scale.width(scale) * 0.43,
        child: Center(
          child: UIText(type!.name, color: Colors.white, fontSize: (scale / 15) * AppFontSize.s4, isCapitalized: true),
        ),
      ),
    );
  }
}
