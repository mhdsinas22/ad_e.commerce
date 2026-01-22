import 'package:ad_e_commerce/features/checkout/data/datasource/address_remote_datasource.dart';
import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';
import 'package:ad_e_commerce/features/checkout/domain/enitites/address_entity.dart';
import 'package:ad_e_commerce/features/checkout/domain/repositories/address_repository.dart';

class AddressRepositoryimpl implements AddressRepository {
  final AddressRemoteDatasource remote;
  AddressRepositoryimpl(this.remote);
  @override
  Future<List<AddressEntity>> getAddresses() async {
    final result = await remote.getAddresses();

    return result.map((e) => e).toList();
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
