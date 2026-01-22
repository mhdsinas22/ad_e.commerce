import 'package:ad_e_commerce/features/checkout/domain/enitites/address_entity.dart';

enum AddressStatus { initial, loading, success, error }

class AddressState {
  final AddressStatus status;
  final String error;
  final List<AddressEntity> addresses;
  AddressState({
    this.addresses = const [],
    this.error = "",
    this.status = AddressStatus.initial,
  });
  AddressState copyWith({
    AddressStatus? status,
    String? error,
    List<AddressEntity>? addresses,
  }) {
    return AddressState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      error: error ?? this.error,
    );
  }
}
