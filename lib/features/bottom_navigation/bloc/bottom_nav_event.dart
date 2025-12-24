abstract class BottomNavEvent {}

class BottomNavChanged extends BottomNavEvent {
  final int index;
  BottomNavChanged({required this.index});
}
