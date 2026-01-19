import 'package:ad_e_commerce/features/product/bloc/banners/banner_event.dart';
import 'package:ad_e_commerce/features/product/bloc/banners/banner_state.dart';
import 'package:ad_e_commerce/features/product/domain/repositories/banner_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository repository;
  BannerBloc(this.repository) : super(BannerState.initial()) {
    on<LoadBannerEvent>(_loadBanners);
  }
  Future<void> _loadBanners(
    LoadBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(state.copyWith(status: BannerStatus.loading));
    try {
      final banners = await repository.getBanners();
      emit(state.copyWith(status: BannerStatus.success, images: banners));
    } catch (e) {
      emit(
        state.copyWith(status: BannerStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
