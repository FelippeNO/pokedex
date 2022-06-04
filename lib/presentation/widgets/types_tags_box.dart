import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';
import 'package:pokedex/core/ui/ui_text.dart';
import 'package:pokedex/domain/entities/type_entity.dart';
import 'package:pokedex/presentation/widgets/primary_type_tag.dart';

class TypesTagsBox extends StatelessWidget {
  final String relation;
  final List<TypeEntity>? types;

  const TypesTagsBox({
    Key? key,
    required this.types,
    required this.relation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Scale.width(2), bottom: Scale.width(2)),
          child: UIText(relation),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: Scale.width(1)),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: Scale.width(70),
            child: Padding(
              padding: EdgeInsets.all(Scale.width(2)),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: Scale.width(9),
                    crossAxisCount: 3,
                    crossAxisSpacing: Scale.width(1),
                    mainAxisSpacing: Scale.width(1),
                    childAspectRatio: 1),
                children: [
                  if (types != null)
                    for (final type in types!) PrimaryTypeTag(type: type, scale: Scale.width(5)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
