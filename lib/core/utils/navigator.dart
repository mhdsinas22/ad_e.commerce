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

  static pushnamed(BuildContext context, String named, Object? arguments) {
    Navigator.pushNamed(context, named, arguments: arguments);
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

  static void pushNamedAndRemoveUntil(
    BuildContext context,
    String named, {
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      named,
      (route) => false,
      arguments: arguments,
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
