import 'package:ad_e_commerce/features/product/domain/entites/banner_entity.dart';

enum BannerStatus { loading, success, error }

class BannerState {
  final BannerStatus status;
  final List<BannerEntity> images;
  final String? errorMessage;

  const BannerState({
    required this.status,
    required this.images,
    this.errorMessage,
  });

  factory BannerState.initial() {
    return const BannerState(status: BannerStatus.loading, images: []);
  }

  BannerState copyWith({
    BannerStatus? status,
    List<BannerEntity>? images,
    String? errorMessage,
  }) {
    return BannerState(
      status: status ?? this.status,
      images: images ?? this.images,
      errorMessage: errorMessage,
    );
  }
}
