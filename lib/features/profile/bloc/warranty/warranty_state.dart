import 'package:aerstore/features/profile/domain/enitites/wallet/warranty.dart';
import 'package:aerstore/features/profile/domain/enitites/warranty_card.dart';

enum WarrantyStatus { inital, loading, success, failue }

class WarrantyState {
  final WarrantyStatus status;
  final List<Warranty> warranties;
  final String? error;
  final WarrantyCard? card;
  final Warranty? selectedWarranty;
  WarrantyState({
    this.status = WarrantyStatus.inital,
    this.warranties = const [],
    this.error,
    this.selectedWarranty,
    this.card,
  });
  WarrantyState copyWith({
    WarrantyStatus? status,
    List<Warranty>? warranties,
    WarrantyCard? card,
    String? error,
    Warranty? selectedWarranty,
  }) {
    return WarrantyState(
      status: status ?? this.status,
      error: error,
      warranties: warranties ?? this.warranties,
      card: card ?? this.card,
      selectedWarranty: selectedWarranty ?? this.selectedWarranty,
    );
  }
}
