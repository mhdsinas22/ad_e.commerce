import 'package:flutter/material.dart';

class AppTexts {
  AppTexts._();

  static const String _fontFamily = "Manrope";

  // ---------- THIN (w100) ----------
  // static Text thin(
  //   String text, {
  //   double fontSize = 14,
  //   Color color = Colors.black,
  //   TextAlign align = TextAlign.start,
  //   double height = 1.2,
  // }) {
  //   return _text(text, fontSize, FontWeight.w100, color, align, height);
  // }

  // ---------- EXTRA LIGHT (w200) ----------
  static Text extraLight(
    String text, {
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w200, color, align, height);
  }

  // ---------- LIGHT (w300) ----------
  static Text light(
    String text, {
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w300, color, align, height);
  }

  // ---------- REGULAR (w400) ----------
  static Text regular(
    String text, {
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w400, color, align, height);
  }

  // ---------- MEDIUM (w500) ----------
  static Text medium(
    String text, {
    double fontSize = 15,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w500, color, align, height);
  }

  // ---------- SEMI BOLD (w600) ----------
  static Text semiBold(
    String text, {
    double fontSize = 16,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w600, color, align, height);
  }

  // ---------- BOLD (w700) ----------
  static Text bold(
    String text, {
    double fontSize = 18,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w700, color, align, height);
  }

  // ---------- EXTRA BOLD (w800) ----------
  static Text extraBold(
    String text, {
    double fontSize = 18,
    Color color = Colors.black,
    TextAlign align = TextAlign.start,
    double height = 1.2,
  }) {
    return _text(text, fontSize, FontWeight.w800, color, align, height);
  }

  // ---------- BLACK (w900) ----------
  // static Text black(
  //   String text, {
  //   double fontSize = 20,
  //   Color color = Colors.black,
  //   TextAlign align = TextAlign.start,
  //   double height = 1.2,
  // }) {
  //   return _text(text, fontSize, FontWeight.w900, color, align, height);
  // }

  // ---------- COMMON METHOD ----------
  static Text _text(
    String text,
    double fontSize,
    FontWeight weight,
    Color color,
    TextAlign align,
    double height,
  ) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontFamily: _fontFamily,
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        height: height, // 🔥 YOU MISSED THIS
      ),
    );
  }
}
