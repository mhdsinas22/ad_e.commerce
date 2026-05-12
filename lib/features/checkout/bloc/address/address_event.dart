import 'package:aerstore/features/checkout/data/models/address_model.dart';

abstract class AddressEvent {}

class SubmitAddressEvent extends AddressEvent {
  final AddressModel address;
  SubmitAddressEvent(this.address);
}

class FetchAddressEvent extends AddressEvent {}

class UpdateAddressEvent extends AddressEvent {
  final AddressModel address;
  UpdateAddressEvent(this.address);
}

class DeleteAddressEvent extends AddressEvent {
  final String id;
  DeleteAddressEvent(this.id);
}

class SelectAddressEvent extends AddressEvent {
  final int index;
  SelectAddressEvent(this.index);
}
