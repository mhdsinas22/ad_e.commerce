import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_state.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/warranty_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WarrantyBloc extends Bloc<WarrantyEvent, WarrantyState> {
  final WarrantyRepository warrantyRepository;
  WarrantyBloc(this.warrantyRepository) : super(WarrantyState()) {
    on<LoadWarrantiesEvent>(_loadWarrantiesEvent);
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
      final warranites = await warrantyRepository.getWarranties(user.id);
      emit(
        state.copyWith(warranties: warranites, status: WarrantyStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(status: WarrantyStatus.failue, error: e.toString()));
    }
  }
}
