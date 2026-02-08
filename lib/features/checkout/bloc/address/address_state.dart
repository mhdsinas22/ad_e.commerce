import 'package:ad_e_commerce/features/checkout/domain/enitites/address_entity.dart';

enum AddressStatus { initial, loading, success, error }

class AddressState {
  final AddressStatus status;
  final String error;
  final List<AddressEntity> addresses;
  final int selectedAddressIndex;
  AddressState({
    this.addresses = const [],
    this.error = "",
    this.status = AddressStatus.initial,
    this.selectedAddressIndex = -1,
  });
  AddressState copyWith({
    AddressStatus? status,
    String? error,
    List<AddressEntity>? addresses,
    int? selectedAddressIndex,
  }) {
    return AddressState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      error: error ?? this.error,
      selectedAddressIndex: selectedAddressIndex ?? this.selectedAddressIndex,
    );
  }
}
