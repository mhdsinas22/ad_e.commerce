class Helpers {
  Helpers._();
  static Future<void> delay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}
