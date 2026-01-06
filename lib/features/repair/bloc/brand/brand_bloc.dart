import 'package:ad_e_commerce/core/constants/asset_constants.dart';
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

class ClearBrand extends BrandEvent {}

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
    on<ClearBrand>(_clearBrand);
  }

  void _onLoadBrands(LoadBrands event, Emitter<BrandState> emit) {
    // Static data matching the image
    final brands = [
      {
        'name': 'Apple',
        'logo': AssetConstants.applelogopng,
      }, // Placeholder paths
      {'name': 'Mi', 'logo': AssetConstants.milogopng},
      {'name': 'Samsung', 'logo': AssetConstants.samsungLogopng},
      {'name': 'Vivo', 'logo': AssetConstants.vivoLogopng},
      {'name': 'OnePlus', 'logo': AssetConstants.oneplusLogo},
      {'name': 'Oppo', 'logo': AssetConstants.oppoLogopng},
      {'name': 'Realme', 'logo': AssetConstants.realmeLogopng},
      {'name': 'Motorola', 'logo': AssetConstants.motorolapng},
      {'name': 'Nokia', 'logo': AssetConstants.nokiapng},
      {'name': 'Honor', 'logo': AssetConstants.honorpng},
      {'name': 'Asus', 'logo': AssetConstants.asuspng},
      {'name': 'Google', 'logo': AssetConstants.googlepng},
      {'name': 'Poco', 'logo': AssetConstants.pocopng},
      {'name': 'Infinix', 'logo': AssetConstants.infinixpng},
      {'name': 'iQOO', 'logo': AssetConstants.iqoo},
      {'name': 'Nothing', 'logo': AssetConstants.nothing},
    ];
    emit(state.copyWith(brands: brands));
  }

  void _onSelectBrand(SelectBrand event, Emitter<BrandState> emit) {
    emit(state.copyWith(selectedBrand: event.brandName));
  }

  void _clearBrand(ClearBrand event, Emitter<BrandState> emit) {
    emit(state.copyWith(selectedBrand: ""));
  }
}
