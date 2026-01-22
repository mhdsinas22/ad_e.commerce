import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';
import 'package:ad_e_commerce/features/checkout/domain/enitites/address_entity.dart';

abstract class AddressRepository {
  Future<List<AddressEntity>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String id);
}
