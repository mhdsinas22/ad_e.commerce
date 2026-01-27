import 'package:ad_e_commerce/features/profile/domain/enitites/warranty.dart';

enum WarrantyStatus { inital, loading, success, failue }

class WarrantyState {
  final WarrantyStatus status;
  final List<Warranty> warranties;
  final String? error;
  WarrantyState({
    this.status = WarrantyStatus.inital,
    this.warranties = const [],
    this.error,
  });
  WarrantyState copyWith({
    WarrantyStatus? status,
    List<Warranty>? warranties,
    String? error,
  }) {
    return WarrantyState(
      status: status ?? this.status,
      error: error,
      warranties: warranties ?? this.warranties,
    );
  }
}
