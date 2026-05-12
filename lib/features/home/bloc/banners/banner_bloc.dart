import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/home/bloc/banners/banner_event.dart';
import 'package:aerstore/features/home/bloc/banners/banner_state.dart';
import 'package:aerstore/features/home/domain/repositories/airdropbenfits_repository.dart';
import 'package:aerstore/features/home/domain/repositories/banner_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository repository;
  final AirdropbenfitsRepository airdropbenfitsRepository;
  BannerBloc(this.repository, this.airdropbenfitsRepository)
    : super(BannerState.initial()) {
    on<LoadBannerEvent>(_loadBanners);
    on<LoadAirdropBannerEvent>(_loadAirdropBanners);
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

  Future<void> _loadAirdropBanners(
    LoadAirdropBannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(state.copyWith(status: BannerStatus.loading));

    try {
      final airdropbanners = await airdropbenfitsRepository.getairdropBanners();

      emit(
        state.copyWith(
          status: BannerStatus.success,
          airdropbenfites: airdropbanners,
        ),
      );
    } catch (e) {
      AppLogger.error("Error:-${e.toString()}");
      emit(
        state.copyWith(status: BannerStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
