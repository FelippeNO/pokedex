import 'package:flutter/material.dart';
import 'package:pokedex/core/ui/scale.dart';

class RoundedDefaultContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  const RoundedDefaultContainer({Key? key, this.child = const SizedBox(), this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Scale.width(5)),
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white.withOpacity(0.6),
            width: Scale.width(1.5),
          ),
        ),
        child: child);
  }
}
