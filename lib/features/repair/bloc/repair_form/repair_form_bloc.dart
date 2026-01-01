import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ad_e_commerce/features/repair/domain/entities/repair_request_entity.dart';
import 'package:ad_e_commerce/features/repair/domain/repositories/repair_repository.dart';

// --- Events ---
abstract class RepairFormEvent extends Equatable {
  const RepairFormEvent();
  @override
  List<Object?> get props => [];
}

class SubmitRepairRequest extends RepairFormEvent {
  final String? brand;
  final List<String> services;
  final String deviceModel;
  final String complaintDescription;
  final List<File> images;
  final String name;
  final String mobileNumber;
  final String email;
  final String location;

  const SubmitRepairRequest({
    required this.brand,
    required this.services,
    required this.deviceModel,
    required this.complaintDescription,
    required this.images,
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.location,
  });

  @override
  List<Object?> get props => [
    brand,
    services,
    deviceModel,
    complaintDescription,
    images,
    name,
    mobileNumber,
    email,
    location,
  ];
}

// --- States ---
enum FormStatus { initial, loading, success, failure }

class RepairFormState extends Equatable {
  final FormStatus status;
  final String? errorMessage;

  const RepairFormState({this.status = FormStatus.initial, this.errorMessage});

  RepairFormState copyWith({FormStatus? status, String? errorMessage}) {
    return RepairFormState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage, // Nullable override
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}

// --- BLoC ---
class RepairFormBloc extends Bloc<RepairFormEvent, RepairFormState> {
  final RepairRepository repository;

  RepairFormBloc({required this.repository}) : super(const RepairFormState()) {
    on<SubmitRepairRequest>(_onSubmitRepairRequest);
  }

  Future<void> _onSubmitRepairRequest(
    SubmitRepairRequest event,
    Emitter<RepairFormState> emit,
  ) async {
    // 1. Validation Logic
    if (event.brand == null || event.brand!.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Please select a brand",
        ),
      );
      return;
    }
    if (event.services.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Please select at least one service",
        ),
      );
      return;
    }
    if (event.deviceModel.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Device model is required",
        ),
      );
      return;
    }
    if (event.complaintDescription.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Complaint description is required",
        ),
      );
      return;
    }
    if (event.name.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Name is required",
        ),
      );
      return;
    }
    if (event.mobileNumber.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Mobile number is required",
        ),
      );
      return;
    }
    if (event.email.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Email is required",
        ),
      );
      return;
    }
    // Location is optional in some flows, but usually required. Let's assume required based on UI.
    if (event.location.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: "Location is required",
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormStatus.loading));

    try {
      final requestEntity = RepairRequestEntity(
        brand: event.brand!,
        services: event.services,
        deviceModel: event.deviceModel,
        complaintDescription: event.complaintDescription,
        imageUrls: [], // Will be handled by repo upload logic
        name: event.name,
        mobileNumber: event.mobileNumber,
        email: event.email,
        location: event.location,
        createdAt: DateTime.now(),
      );

      await repository.submitRepairRequest(
        request: requestEntity,
        images: event.images,
      );

      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: FormStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
