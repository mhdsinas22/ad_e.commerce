import 'package:ad_e_commerce/core/error/exceptions.dart';
import 'package:ad_e_commerce/features/home/data/datasource/testimonial_remote_datasoure.dart';
import 'package:ad_e_commerce/features/home/data/repository/testimonials_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TestimonialRemoteDatasoureimpl implements TestimonialRemoteDatasoure {
  final SupabaseClient supabase;
  TestimonialRemoteDatasoureimpl({required this.supabase});
  @override
  Future<List<TestmonialModel>> getTestimonials() async {
    try {
      final response = await supabase.from("testimonials").select("*");
      return response.map((e) => TestmonialModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addTestimonial(TestmonialModel testmonial) async {
    try {
      await supabase.from("testimonials").insert(testmonial.toJson());
    } catch (e) {
      throw ServerException(" add remote die${e.toString()}");
    }
  }

  @override
  Future<void> updateTestimonial(TestmonialModel testmonial) async {
    try {
      await supabase
          .from("testimonials")
          .update(testmonial.toJson())
          .eq("id", testmonial.id.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTestimonial(String id) async {
    try {
      await supabase.from("testimonials").delete().eq("id", id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
