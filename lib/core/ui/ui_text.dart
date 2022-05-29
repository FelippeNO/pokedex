import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/core/extensions/string_extension.dart';
import 'scale.dart';

class UIText extends StatelessWidget {
  const UIText(
    this.text, {
    Key? key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.isCapitalized,
    this.decoration,
    this.lineHeight,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontStyle,
  }) : super(key: key);

  final String text;
  final bool? isCapitalized;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final double? lineHeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      isCapitalized == true ? text.capitalize() : text,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        letterSpacing: -0.1,
        height: lineHeight,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? AppFontSize.s2,
        color: color ?? Colors.white,
        decoration: decoration ?? TextDecoration.none,
        fontStyle: fontStyle,
      ),
    );
  }
}
