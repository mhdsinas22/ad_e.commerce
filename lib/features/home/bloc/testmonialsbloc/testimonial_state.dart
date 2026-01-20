import 'package:ad_e_commerce/features/home/domain/enitites/testimonials_entity.dart';

enum TestimonialStatus { initial, loading, success, failure }

class TestimonialState {
  final TestimonialStatus status;
  final String errormessge;
  final List<TestmonialEntity> testmonial;
  TestimonialState({
    this.testmonial = const [],
    this.errormessge = "",
    this.status = TestimonialStatus.initial,
  });
  TestimonialState copyWith({
    TestimonialStatus? status,
    String? errormessge,
    List<TestmonialEntity>? testmonial,
  }) {
    return TestimonialState(
      status: status ?? this.status,
      errormessge: errormessge ?? this.errormessge,
      testmonial: testmonial ?? this.testmonial,
    );
  }
}
