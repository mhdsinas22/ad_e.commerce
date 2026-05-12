import 'package:aerstore/features/home/data/repository/testimonials_model.dart';

abstract class TestimonialRemoteDatasoure {
  Future<List<TestmonialModel>> getTestimonials();
  Future<void> addTestimonial(TestmonialModel testimonial);
  Future<void> updateTestimonial(TestmonialModel testimonial);
  Future<void> deleteTestimonial(String id);
}
