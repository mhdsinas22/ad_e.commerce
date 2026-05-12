import 'package:aerstore/features/home/data/datasource/testimonial_remote_datasoure.dart';
import 'package:aerstore/features/home/data/repository/testimonials_model.dart';
import 'package:aerstore/features/home/domain/repositories/testmonial_repository.dart';

class TestmonialRepositoryimpl implements TestmonialRepository {
  final TestimonialRemoteDatasoure remote;
  TestmonialRepositoryimpl({required this.remote});
  @override
  Future<List<TestmonialModel>> getTestimonials() async {
    return remote.getTestimonials();
  }

  @override
  Future<void> addTestimonial(TestmonialModel testmonial) async {
    return remote.addTestimonial(testmonial);
  }

  @override
  Future<void> updateTestimonial(TestmonialModel testmonial) async {
    return remote.updateTestimonial(testmonial);
  }

  @override
  Future<void> deleteTestimonial(String id) async {
    return remote.deleteTestimonial(id);
  }
}
