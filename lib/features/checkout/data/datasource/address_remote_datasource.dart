import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';

abstract class AddressRemoteDatasource {
  Future<List<AddressModel>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String id);
}
