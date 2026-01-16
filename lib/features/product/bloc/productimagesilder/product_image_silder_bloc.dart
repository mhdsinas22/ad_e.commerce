import 'dart:async';

import 'package:ad_e_commerce/features/product/bloc/productimagesilder/product_image_silder_state.dart';
import 'package:ad_e_commerce/features/product/bloc/productimagesilder/product_image_slider_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImageSilderBloc
    extends Bloc<ProductImageSliderEvent, ProductImageSilderState> {
  Timer? timer;
  final int imagecount;
  ProductImageSilderBloc({required this.imagecount})
    : super(ProductImageSilderState(currentIndex: 0)) {
    on<StartAutoSlide>(_startAutoSlider);
    on<SliderChangedEvent>(_sliderChanged);
    on<AutoSlideTickEvent>(_autoSliderTick);
  }
  void _startAutoSlider(
    ProductImageSliderEvent event,
    Emitter<ProductImageSilderState> emit,
  ) {
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => add(AutoSlideTickEvent()),
    );
  }

  void _autoSliderTick(
    AutoSlideTickEvent event,
    Emitter<ProductImageSilderState> emit,
  ) {
    final nextindex = (state.currentIndex + 1) % imagecount;
    emit(state.copyWith(currentIndex: nextindex));
  }

  void _sliderChanged(
    SliderChangedEvent event,
    Emitter<ProductImageSilderState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
