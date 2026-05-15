import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/checkout/data/datasource/address_remote_datasource.dart';
import 'package:aerstore/features/checkout/data/models/address_model.dart';
import 'package:aerstore/features/checkout/domain/enitites/address_entity.dart';
import 'package:aerstore/features/checkout/domain/repositories/address_repository.dart';

class AddressRepositoryimpl implements AddressRepository {
  final AddressRemoteDatasource remote;
  AddressRepositoryimpl(this.remote);
  
  @override
  Future<List<AddressEntity>> getAddresses() async {
    final box = Hive.box("address_cache");
    try {
      final result = await remote.getAddresses();
      
      // Cache the result
      final jsonList = result.map((e) => jsonEncode(e.toJson())).toList();
      await box.put('addresses', jsonList);

      return result.map((e) => e).toList();
    } catch (e) {
      AppLogger.error("Error fetching addresses remotely, falling back to cache: $e");
      
      // Fallback to local cache
      final cachedData = box.get('addresses') as List<dynamic>?;
      if (cachedData != null) {
        try {
          final List<AddressModel> localAddresses = cachedData
              .map((e) => AddressModel.fromJson(jsonDecode(e.toString())))
              .toList();
          return localAddresses;
        } catch (parseError) {
          AppLogger.error("Error parsing cached addresses: $parseError");
        }
      }
      return [];
    }
  }

  @override
  Future<void> addAddress(AddressModel address) {
    return remote.addAddress(address);
  }

  @override
  Future<void> updateAddress(AddressModel address) {
    return remote.updateAddress(address);
  }

  @override
  Future<void> deleteAddress(String id) {
    return remote.deleteAddress(id);
  }
}
