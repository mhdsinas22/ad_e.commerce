class ProductImageSilderState {
  final int currentIndex;
  ProductImageSilderState({required this.currentIndex});
  ProductImageSilderState copyWith({int? currentIndex}) {
    return ProductImageSilderState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
