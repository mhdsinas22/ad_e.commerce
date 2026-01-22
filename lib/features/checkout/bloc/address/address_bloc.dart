import 'package:ad_e_commerce/features/checkout/bloc/address/address_event.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_state.dart';
import 'package:ad_e_commerce/features/checkout/domain/repositories/address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;
  AddressBloc(this.addressRepository) : super(AddressState()) {
    on<SubmitAddressEvent>(_submitAddress);
    on<FetchAddressEvent>(_fetchAddress);
  }
  Future<void> _submitAddress(
    SubmitAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: AddressStatus.loading));
    print("wokribsubmit");
    try {
      await addressRepository.addAddress(event.address);
      emit(state.copyWith(status: AddressStatus.success));
    } catch (e) {
      print("Weeoe:-${e.toString()}");
      emit(state.copyWith(status: AddressStatus.error, error: e.toString()));
    }
  }

  Future<void> _fetchAddress(
    FetchAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: AddressStatus.loading));
    print("Feethc wrokds");
    try {
      final address = await addressRepository.getAddresses();
      print("ADdes:-${address}");
      emit(state.copyWith(addresses: address));
    } catch (e) {
      print("error:-${e.toString()}");
    }
  }
}
