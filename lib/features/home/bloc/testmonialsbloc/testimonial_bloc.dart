import 'package:aerstore/features/home/bloc/testmonialsbloc/testimonial_event.dart';
import 'package:aerstore/features/home/bloc/testmonialsbloc/testimonial_state.dart';
import 'package:aerstore/features/home/domain/repositories/testmonial_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestimonialBloc extends Bloc<TestimonialEvent, TestimonialState> {
  final TestmonialRepository repository;
  TestimonialBloc(this.repository) : super(TestimonialState()) {
    on<LoadTestimonialEvent>(_loadTestimonialEvent);
  }
  Future<void> _loadTestimonialEvent(
    LoadTestimonialEvent event,
    Emitter<TestimonialState> emit,
  ) async {
    emit(state.copyWith(status: TestimonialStatus.loading));
    try {
      final result = await repository.getTestimonials();
      emit(
        state.copyWith(status: TestimonialStatus.success, testmonial: result),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errormessge: e.toString(),
          status: TestimonialStatus.failure,
        ),
      );
    }
  }
}
