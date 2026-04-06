import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTexts {
  AppTexts._();

  static const String _fontFamily = "Inter";

  // ---------- EXTRA LIGHT (w200) ----------
  static Text extraLight(
    String text, {
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w200,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- LIGHT (w300) ----------
  static Text light(
    String text, {
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w300,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- REGULAR (w400) ----------
  static Text regular(
    String text, {
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w400,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- MEDIUM (w500) ----------
  static Text medium(
    String text, {
    double fontSize = 15,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w500,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- SEMI BOLD (w600) ----------
  static Text semiBold(
    String text, {
    double fontSize = 16,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w600,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- BOLD (w700) ----------
  static Text bold(
    String text, {
    double fontSize = 18,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w700,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- EXTRA BOLD (w800) ----------
  static Text extraBold(
    String text, {
    double fontSize = 18,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
    bool isOffer = false,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return _text(
      text,
      fontSize,
      FontWeight.w800,
      color,
      align,
      height,
      isOffer ? TextDecoration.lineThrough : null,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      letterSpacing: letterSpacing,
    );
  }

  // ---------- COMMON METHOD ----------
  static Text _text(
    String text,
    double fontSize,
    FontWeight weight,
    Color color,
    TextAlign align,
    double height,
    TextDecoration? decoration, {
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = false,
    double? letterSpacing,
  }) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis, // 🔥 safe default
      softWrap: softWrap,
      style: TextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        height: height,
        decoration: decoration,
        decorationColor: AppColors.grayColor,
        decorationThickness: 1.4,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
