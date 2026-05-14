class AppNavigationHistory {
  static final List<String> _history = [];
  static void add(String route) {
    if (_history.isEmpty || _history.last != route) {
      _history.add(route);
    }
  }

  static String? pop() {
    if (_history.length > 1) {
      _history.removeLast();
      return _history.last;
    }
    return null;
  }
}
