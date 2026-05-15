import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/checkout/bloc/address/address_event.dart';
import 'package:aerstore/features/checkout/bloc/address/address_state.dart';
import 'package:aerstore/features/checkout/domain/repositories/address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      
      // Select the newly added address automatically
      final newIndex = updatedList.length - 1;
      final box = Hive.box("address_cache");
      await box.put("selectedAddressIndex", newIndex);

      emit(
        state.copyWith(
            status: AddressStatus.success, 
            addresses: updatedList,
            selectedAddressIndex: newIndex,
        ),
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
      
      // Load persisted selected index
      final box = Hive.box("address_cache");
      int savedIndex = box.get("selectedAddressIndex", defaultValue: -1);
      
      // Ensure the saved index is valid
      if (address.isNotEmpty && (savedIndex < 0 || savedIndex >= address.length)) {
        savedIndex = 0; // Default to first address if invalid
      } else if (address.isEmpty) {
        savedIndex = 0; // Point to "Add New" implicitly
      }

      AppLogger.info("Address::-$address");
      emit(state.copyWith(
        status: AddressStatus.success,
        addresses: address,
        selectedAddressIndex: savedIndex,
      ));
    } catch (e) {
      AppLogger.error("error:-${e.toString()}");
      emit(state.copyWith(status: AddressStatus.error, error: e.toString()));
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
      
      // Reset selected index after deletion to avoid out of bounds
      final box = Hive.box("address_cache");
      int savedIndex = updatedList.isNotEmpty ? 0 : 0;
      await box.put("selectedAddressIndex", savedIndex);

      emit(
        state.copyWith(
            status: AddressStatus.success, 
            addresses: updatedList,
            selectedAddressIndex: savedIndex,
        ),
      );
    } catch (e) {
      AppLogger.error("Delete error:_${e.toString()}");
      emit(state.copyWith(status: AddressStatus.error, error: e.toString()));
    }
  }

  void _selectAddress(SelectAddressEvent event, Emitter<AddressState> emit) {
    final box = Hive.box("address_cache");
    box.put("selectedAddressIndex", event.index);
    emit(state.copyWith(selectedAddressIndex: event.index));
  }
}
