import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_state.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/warranty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WarrantyBloc extends Bloc<WarrantyEvent, WarrantyState> {
  final WarrantyRepository warrantyRepository;
  WarrantyBloc(this.warrantyRepository) : super(WarrantyState()) {
    on<LoadWarrantiesEvent>(_loadWarrantiesEvent);
    on<SelectWarrantyEvent>(_onSelectWarrantyEvent);
  }
  Future<void> _loadWarrantiesEvent(
    LoadWarrantiesEvent event,
    Emitter<WarrantyState> emit,
  ) async {
    emit(state.copyWith(status: WarrantyStatus.loading));
    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        emit(
          state.copyWith(
            status: WarrantyStatus.failue,
            error: "User not logged in",
          ),
        );
        return;
      }
      final result = await warrantyRepository.getWarrantyData(user.id);
      if (result == null) {
        emit(state.copyWith(status: WarrantyStatus.success, warranties: []));
        return;
      }
      emit(
        state.copyWith(
          card: result.card,
          warranties: result.warranties,
          selectedWarranty:
              result.warranties.isNotEmpty ? result.warranties.first : null,
          status: WarrantyStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: WarrantyStatus.failue, error: e.toString()));
    }
  }

  Future<void> _onSelectWarrantyEvent(
    SelectWarrantyEvent event,
    Emitter<WarrantyState> emit,
  ) async {
    emit(state.copyWith(status: WarrantyStatus.loading));
    try {
      emit(
        state.copyWith(
          selectedWarranty: event.warranty,
          status: WarrantyStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: WarrantyStatus.failue, error: e.toString()));
    }
  }
}
