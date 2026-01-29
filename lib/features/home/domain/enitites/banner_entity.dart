import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String? id;

  final List<String> imageUrl;
  final bool isActive; // 'Enabled' or 'Disabled'

  const BannerEntity({this.id, required this.imageUrl, required this.isActive});

  @override
  List<Object?> get props => [id, imageUrl, isActive];
}
