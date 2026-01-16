abstract class ProductImageSliderEvent {}

class StartAutoSlide extends ProductImageSliderEvent {}

class SliderChangedEvent extends ProductImageSliderEvent {
  final int index;
  SliderChangedEvent({required this.index});
}

class AutoSlideTickEvent extends ProductImageSliderEvent {}
