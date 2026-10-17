import 'package:material_ui/material_ui.dart';

part 'text_type.dart';

class const BaseText(
  final String text, {
  super.key,
  final TextAlign? textAlign,
  final TextOverflow? overflow,
  final int? maxLines,
  final Color? color,
  final TextType textType = TextType.bodyMedium,
  final FontWeight fontWeight = FontWeight.normal,
  final TextDecoration? decoration,
  final Color? decorationColor,
}) extends StatelessWidget {
  factory caption(
    String text, {
    TextAlign? textAlign,
    TextOverflow? overflow,
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => BaseText(
    text,
    textAlign: textAlign,
    overflow: overflow,
    color: color,
    textType: TextType.caption,
    fontWeight: fontWeight ?? FontWeight.w400,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  factory bodySmall(
    String text, {
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    Color? decorationColor,
  }) => BaseText(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    color: color,
    textType: TextType.bodySmall,
    fontWeight: fontWeight ?? FontWeight.w400,
    decoration: decoration,
    decorationColor: decorationColor,
  );

  factory bodyLarge(
    String text, {
    TextAlign? textAlign,
    Color? color,
    FontWeight? fontWeight,
  }) => BaseText(
    text,
    textAlign: textAlign,
    color: color,
    textType: TextType.bodyLarge,
    fontWeight: fontWeight ?? FontWeight.w400,
  );

  factory title(String text, {TextAlign? textAlign, Color? color}) => BaseText(
    text,
    textAlign: textAlign,
    color: color,
    textType: TextType.titleSmall,
    fontWeight: FontWeight.w600,
  );

  factory titleMedium(
    String text, {
    TextAlign? textAlign,
    Color? color,
    FontWeight? fontWeight,
  }) => BaseText(
    text,
    textAlign: textAlign,
    color: color,
    textType: TextType.titleMedium,
    fontWeight: fontWeight ?? FontWeight.w600,
  );

  factory headline(String text, {Color? color, FontWeight? fontWeight}) =>
      BaseText(
        text,
        color: color,
        textType: TextType.headline,
        fontWeight: fontWeight ?? FontWeight.w600,
      );

  factory headlineLarge(String text, {Color? color}) => BaseText(
    text,
    color: color,
    textType: TextType.headlineLarge,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: textType.size,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
