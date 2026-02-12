import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_event.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_state.dart';
import 'package:ad_e_commerce/features/checkout/domain/repositories/address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;
  AddressBloc(this.addressRepository) : super(AddressState()) {
    on<SubmitAddressEvent>(_submitAddress);
    on<FetchAddressEvent>(_fetchAddress);
    on<UpdateAddressEvent>(_updateAddress);
    on<DeleteAddressEvent>(_deleteAddress);
    on<SelectAddressEvent>(_selectAddress);
  }
  Future<void> _submitAddress(
    SubmitAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: AddressStatus.loading));
    AppLogger.info("wokribsubmit");
    try {
      await addressRepository.addAddress(event.address);
      final updatedList = await addressRepository.getAddresses();
      emit(
        state.copyWith(status: AddressStatus.success, addresses: updatedList),
      );
    } catch (e) {
      AppLogger.error("Weeoe:-${e.toString()}");
      emit(state.copyWith(status: AddressStatus.error, error: e.toString()));
    }
  }

  Future<void> _fetchAddress(
    FetchAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: AddressStatus.loading));
    AppLogger.info("Feethc wrokds");
    try {
      final address = await addressRepository.getAddresses();
      AppLogger.info("ADdes:-$address");
      emit(state.copyWith(addresses: address));
    } catch (e) {
      AppLogger.error("error:-${e.toString()}");
    }
  }

  Future<void> _updateAddress(
    UpdateAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: AddressStatus.loading));
    try {
      await addressRepository.updateAddress(event.address);
      final updatedList = await addressRepository.getAddresses();

      emit(
        state.copyWith(status: AddressStatus.success, addresses: updatedList),
      );
    } catch (e) {
      AppLogger.error("Update RROR:${e.toString()}");
      emit(state.copyWith(status: AddressStatus.error, error: e.toString()));
    }
  }

  Future<void> _deleteAddress(
    DeleteAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(status: AddressStatus.loading));
    try {
      await addressRepository.deleteAddress(event.id);
      final updatedList = await addressRepository.getAddresses();

      emit(
        state.copyWith(status: AddressStatus.success, addresses: updatedList),
      );
    } catch (e) {
      AppLogger.error("Delete error:_${e.toString()}");
      emit(state.copyWith(status: AddressStatus.error, error: e.toString()));
    }
  }

  void _selectAddress(SelectAddressEvent event, Emitter<AddressState> emit) {
    emit(state.copyWith(selectedAddressIndex: event.index));
  }
}
