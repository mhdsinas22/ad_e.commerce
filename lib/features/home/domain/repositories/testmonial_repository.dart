import 'package:ad_e_commerce/features/home/data/repository/testimonials_model.dart';

abstract class TestmonialRepository {
  Future<List<TestmonialModel>> getTestimonials();
  Future<void> addTestimonial(TestmonialModel testmonial);
  Future<void> updateTestimonial(TestmonialModel testmonial);
  Future<void> deleteTestimonial(String id);
}
