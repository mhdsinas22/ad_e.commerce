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
      {
        'name': 'Apple',
        'logo': AssetConstants.appleIconSvg,
      }, // Placeholder paths
      {'name': 'Mi', 'logo': AssetConstants.miconsvg},
      {'name': 'Samsung', 'logo': AssetConstants.samsunglogosvg},
      {'name': 'Vivo', 'logo': AssetConstants.vivologoSvg},
      {'name': 'Honor', 'logo': AssetConstants.honorlogosvg},
      {'name': 'Oppo', 'logo': AssetConstants.oppologosvg},
      {'name': 'Realme', 'logo': AssetConstants.realmeLogosvg},
      {'name': 'OnePlus', 'logo': AssetConstants.oneplusLogoSvg},
      {'name': 'Nokia', 'logo': AssetConstants.nokiasvg},
      {'name': 'Motorola', 'logo': AssetConstants.motorolasvg},
      {'name': 'Asus', 'logo': AssetConstants.asuslogosvg},
      {'name': 'Google', 'logo': AssetConstants.googlelogosv},
      {'name': 'Poco', 'logo': AssetConstants.pocologoSvg},
      {'name': 'Infinix', 'logo': AssetConstants.infinixsvg},
      {'name': 'iQOO', 'logo': AssetConstants.iqoosvg},
      {'name': 'Nothing', 'logo': AssetConstants.nothingsvg},
    ];
    emit(state.copyWith(brands: brands));
  }

  void _onSelectBrand(SelectBrand event, Emitter<BrandState> emit) {
    emit(state.copyWith(selectedBrand: event.brandName));
  }
}
