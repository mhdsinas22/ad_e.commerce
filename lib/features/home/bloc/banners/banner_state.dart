import 'package:ad_e_commerce/features/home/domain/enitites/airdropbenfites_entity.dart';
import 'package:ad_e_commerce/features/home/domain/enitites/banner_entity.dart';

enum BannerStatus { loading, success, error }

class BannerState {
  final BannerStatus status;
  final List<BannerEntity> images;
  final String? errorMessage;
  final List<AirdropbenfitesEntity> airdropbenfites;

  const BannerState({
    required this.status,
    required this.images,
    this.errorMessage,
    required this.airdropbenfites,
  });

  factory BannerState.initial() {
    return const BannerState(
      status: BannerStatus.loading,
      images: [],
      airdropbenfites: [],
    );
  }

  BannerState copyWith({
    BannerStatus? status,
    List<BannerEntity>? images,
    String? errorMessage,
    List<AirdropbenfitesEntity>? airdropbenfites,
  }) {
    return BannerState(
      status: status ?? this.status,
      images: images ?? this.images,
      errorMessage: errorMessage,
      airdropbenfites: airdropbenfites ?? this.airdropbenfites,
    );
  }
}
