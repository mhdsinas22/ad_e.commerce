class BottomNavState {
  final int selectedIndex;
  const BottomNavState({this.selectedIndex = 0});
  BottomNavState copyWith({int? selectedIndex}) {
    return BottomNavState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
