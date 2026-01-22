import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';

abstract class AddressEvent {}

class SubmitAddressEvent extends AddressEvent {
  final AddressModel address;
  SubmitAddressEvent(this.address);
}

class FetchAddressEvent extends AddressEvent {}
