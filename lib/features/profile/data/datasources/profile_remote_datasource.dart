import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ad_e_commerce/core/error/failures.dart';
import 'package:ad_e_commerce/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile(String userId);
  Future<UserModel> updateProfile(UserModel user);
  Future<String> uploadProfileImage(File imageFile, String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> getProfile(String userId) async {
    try {
      final response =
          await supabaseClient
              .from('users')
              .select()
              .eq('user_id', userId)
              .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      final response =
          await supabaseClient
              .from('users')
              .update(user.toJson())
              .eq('user_id', user.userId)
              .select()
              .single();

      return UserModel.fromJson(response);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName =
          '$userId-${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = fileName;

      await supabaseClient.storage
          .from('profile_images')
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: const FileOptions(contentType: 'image/*'),
          );

      final imageUrl = supabaseClient.storage
          .from('profile_images')
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
