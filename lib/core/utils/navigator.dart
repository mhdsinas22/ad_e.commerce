import 'package:flutter/material.dart';

class Appnavigotor {
  static push(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  static pushnamed(BuildContext context, String named) {
    Navigator.pushNamed(context, named);
  }

  static pushreplace(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }

  static void pushNamedAndRemoveUntil(BuildContext context, String named) {
    Navigator.pushNamedAndRemoveUntil(context, named, (route) => false);
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
