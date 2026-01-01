import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Events ---
abstract class BrandEvent extends Equatable {
  const BrandEvent();
  @override
  List<Object> get props => [];
}

class LoadBrands extends BrandEvent {}

class SelectBrand extends BrandEvent {
  final String brandName;
  const SelectBrand(this.brandName);
  @override
  List<Object> get props => [brandName];
}

// --- States ---
class BrandState extends Equatable {
  final List<Map<String, String>> brands; // {name, logo}
  final String? selectedBrand;

  const BrandState({this.brands = const [], this.selectedBrand});

  BrandState copyWith({
    List<Map<String, String>>? brands,
    String? selectedBrand,
  }) {
    return BrandState(
      brands: brands ?? this.brands,
      selectedBrand: selectedBrand ?? this.selectedBrand,
    );
  }

  @override
  List<Object?> get props => [brands, selectedBrand];
}

// --- BLoC ---
class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(const BrandState()) {
    on<LoadBrands>(_onLoadBrands);
    on<SelectBrand>(_onSelectBrand);
  }

  void _onLoadBrands(LoadBrands event, Emitter<BrandState> emit) {
    // Static data matching the image
    final brands = [
      {'name': 'Apple', 'logo': 'assets/brands/apple.png'}, // Placeholder paths
      {'name': 'Mi', 'logo': 'assets/brands/mi.png'},
      {'name': 'Samsung', 'logo': 'assets/brands/samsung.png'},
      {'name': 'Vivo', 'logo': 'assets/brands/vivo.png'},
      {'name': 'Honor', 'logo': 'assets/brands/honor.png'},
      {'name': 'Oppo', 'logo': 'assets/brands/oppo.png'},
      {'name': 'Realme', 'logo': 'assets/brands/realme.png'},
      {'name': 'OnePlus', 'logo': 'assets/brands/oneplus.png'},
      {'name': 'Nokia', 'logo': 'assets/brands/nokia.png'},
      {'name': 'Motorola', 'logo': 'assets/brands/motorola.png'},
      {'name': 'Asus', 'logo': 'assets/brands/asus.png'},
      {'name': 'Google', 'logo': 'assets/brands/google.png'},
      {'name': 'Poco', 'logo': 'assets/brands/poco.png'},
      {'name': 'Infinix', 'logo': 'assets/brands/infinix.png'},
      {'name': 'iQOO', 'logo': 'assets/brands/iqoo.png'},
      {'name': 'Nothing', 'logo': 'assets/brands/nothing.png'},
    ];
    emit(state.copyWith(brands: brands));
  }

  void _onSelectBrand(SelectBrand event, Emitter<BrandState> emit) {
    emit(state.copyWith(selectedBrand: event.brandName));
  }
}
