class Helpers {
  Helpers._();
  static Future<void> delay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}

Map<String, String> splitWarrantyCode(String code) {
  String letters = '';
  String numbers = '';

  for (int i = 0; i < code.length; i++) {
    if (RegExp(r'[A-Z]').hasMatch(code[i])) {
      letters += code[i];
    } else if (RegExp(r'[0-9]').hasMatch(code[i])) {
      numbers += code[i];
    }
  }

  return {'letters': letters, 'numbers': numbers};
}
