import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class RepairStorageService {
  final SupabaseClient _supabase;

  RepairStorageService({SupabaseClient? supabase})
    : _supabase = supabase ?? Supabase.instance.client;

  static const String _bucketName = 'repair_photos';

  /// Uploads a repair image to Supabase Storage
  /// Returns the public URL of the uploaded image
  /// Throws [StorageException] if upload fails
  Future<String> uploadRepairImage({
    required File file,
    required String userId,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileExtension = file.path.split('.').last;
      final path = '$userId/$timestamp.$fileExtension';

      await _supabase.storage
          .from(_bucketName)
          .upload(
            path,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      return getPublicUrl(path);
    } on StorageException catch (e) {
      throw Exception('Supabase Storage Error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload repair image: $e');
    }
  }

  /// Uploads a repair image from bytes to Supabase Storage
  /// Returns the public URL of the uploaded image
  Future<String> uploadRepairImageBytes({
    required Uint8List bytes,
    required String userId,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      // Default to jpg for bytes as we don't have extension.
      // Ideally we should detect mime type, but jpg is safe for camera/gallery in most cases or just use bin.
      // But user requirement asked for .jpg
      final path = '$userId/$timestamp.jpg';

      await _supabase.storage
          .from(_bucketName)
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
              contentType: 'image/jpeg',
            ),
          );

      return getPublicUrl(path);
    } on StorageException catch (e) {
      throw Exception('Supabase Storage Error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload repair image: $e');
    }
  }

  /// Deletes a repair image from Supabase Storage
  Future<void> deleteRepairImage(String path) async {
    try {
      await _supabase.storage.from(_bucketName).remove([path]);
    } on StorageException catch (e) {
      throw Exception('Supabase Storage Delete Error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete repair image: $e');
    }
  }

  /// Gets the public URL for a stored image
  String getPublicUrl(String path) {
    try {
      return _supabase.storage.from(_bucketName).getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to get public URL: $e');
    }
  }
}
