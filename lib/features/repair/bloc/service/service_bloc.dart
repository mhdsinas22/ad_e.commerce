import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Events ---
abstract class ServiceEvent extends Equatable {
  const ServiceEvent();
  @override
  List<Object> get props => [];
}

class LoadServices extends ServiceEvent {}

class ToggleService extends ServiceEvent {
  final String serviceName;
  const ToggleService(this.serviceName);
  @override
  List<Object> get props => [serviceName];
}

// --- States ---
class ServiceState extends Equatable {
  final List<String> services;
  final List<String> selectedServices;

  const ServiceState({
    this.services = const [],
    this.selectedServices = const [],
  });

  ServiceState copyWith({
    List<String>? services,
    List<String>? selectedServices,
  }) {
    return ServiceState(
      services: services ?? this.services,
      selectedServices: selectedServices ?? this.selectedServices,
    );
  }

  @override
  List<Object> get props => [services, selectedServices];
}

// --- BLoC ---
class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(const ServiceState()) {
    on<LoadServices>(_onLoadServices);
    on<ToggleService>(_onToggleService);
  }

  void _onLoadServices(LoadServices event, Emitter<ServiceState> emit) {
    final services = [
      'Screen',
      'Charging',
      'Water Damage',
      'Battery',
      'Camera',
      'Software',
      'Mic / Audio',
      'Back Panel',
      'Cleaning',
    ];
    emit(state.copyWith(services: services));
  }

  void _onToggleService(ToggleService event, Emitter<ServiceState> emit) {
    final updatedSelection = List<String>.from(state.selectedServices);
    if (updatedSelection.contains(event.serviceName)) {
      updatedSelection.remove(event.serviceName);
    } else {
      updatedSelection.add(event.serviceName);
    }
    emit(state.copyWith(selectedServices: updatedSelection));
  }
}
