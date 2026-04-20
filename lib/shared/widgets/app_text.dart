import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTextFont { inter, jakarta }

class AppText extends StatelessWidget {
  final String text;
  final AppTextFont font;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.font = AppTextFont.inter,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  const AppText.headline(this.text, {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
    : font = AppTextFont.jakarta,
      fontSize = 22,
      fontWeight = FontWeight.w700,
      letterSpacing = -0.4,
      height = null;

  const AppText.title(this.text, {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
    : font = AppTextFont.jakarta,
      fontSize = 15,
      fontWeight = FontWeight.w600,
      letterSpacing = null,
      height = null;

  const AppText.body(this.text, {super.key, this.color, this.height, this.textAlign, this.maxLines, this.overflow})
    : font = AppTextFont.inter,
      fontSize = 14,
      fontWeight = FontWeight.w400,
      letterSpacing = null;

  const AppText.bodySmall(this.text, {super.key, this.color, this.height, this.textAlign, this.maxLines, this.overflow})
    : font = AppTextFont.inter,
      fontSize = 12,
      fontWeight = FontWeight.w400,
      letterSpacing = null;

  const AppText.label(this.text, {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
    : font = AppTextFont.inter,
      fontSize = 11,
      fontWeight = FontWeight.w500,
      letterSpacing = 0.04,
      height = null;

  const AppText.button(this.text, {super.key, this.color, this.textAlign, this.maxLines, this.overflow})
    : font = AppTextFont.jakarta,
      fontSize = 14,
      fontWeight = FontWeight.w600,
      letterSpacing = null,
      height = null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    final style = font == AppTextFont.jakarta
        ? GoogleFonts.plusJakartaSans(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? defaultColor,
            letterSpacing: letterSpacing,
            height: height,
          )
        : GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? defaultColor,
            letterSpacing: letterSpacing,
            height: height,
          );

    return Text(text, style: style, textAlign: textAlign, maxLines: maxLines, overflow: overflow);
  }
}
