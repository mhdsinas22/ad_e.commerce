import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aerstore/core/error/failures.dart';
import 'package:aerstore/data/models/user_model.dart';

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
              .from('profiles')
              .select()
              .eq('user_id', userId)
              .single();

      var user = UserModel.fromJson(response);

      // Ensure we explicitly generate a signed URL for the profile image
      // because the bucket is private and we enforce strict paths.
      // This handles cases where the DB might have an expired URL or just the path.
      // We generate a signed URL for the standard path: {username}/profile.jpg
      if (user.username.isNotEmpty) {
        final path = '${user.username}/profile.jpg';
        try {
          // Check if we should sign. If the image_url in DB is already a signed URL
          // that works, great. But we can't easily validate it.
          // Securest approach: Always provide a fresh Signed URL for our governed path.
          // This ensures if the user has a file there, they can see it.
          // We use a long expiry (e.g. 24h).

          // Note: createSignedUrl does NOT check file existence.
          // It just creates a signature. If file is missing, it 404s.
          final signedUrl = await supabaseClient.storage
              .from('profile_images')
              .createSignedUrl(path, 60 * 60 * 24);

          user = user.copyWith(imageUrl: signedUrl);
        } catch (_) {
          // If signing fails (e.g. network), we keep the original value or ignore.
        }
      }

      return user;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      final response =
          await supabaseClient
              .from('profiles')
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
      // 1. Get the user profile to find the username
      // We need the username to construct the path: profile_images/{username}/profile.jpg
      final userProfile = await getProfile(userId);
      final username = userProfile.username;

      if (username.isEmpty) {
        throw const ServerFailure('User does not have a username');
      }

      final bytes = await imageFile.readAsBytes();
      // Ensure we use the exact path requested: {username}/profile.jpg
      final fileName = 'profile.jpg';
      final filePath = '$username/$fileName';

      // 2. Upload the file (Upsert is true to replace old image)
      await supabaseClient.storage
          .from('profile_images')
          .uploadBinary(
            filePath,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );

      // 3. Generate a Signed URL for the uploaded image
      // Because the bucket is private (as per requirement 5: "Only the authenticated user can... Read"),
      // we must use createSignedUrl.
      final signedUrl = await supabaseClient.storage
          .from('profile_images')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365);
      // 1 year expiry for simplicity, or better, the UI should call createSignedUrl when rendering.

      return signedUrl;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
