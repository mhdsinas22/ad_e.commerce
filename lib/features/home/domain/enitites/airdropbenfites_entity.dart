class AirdropbenfitesEntity {
  final String? id;

  final List<String> imageUrl;
  final bool isActive; // 'Enabled' or 'Disabled'

  const AirdropbenfitesEntity({
    this.id,
    required this.imageUrl,
    required this.isActive,
  });

  List<Object?> get props => [id, imageUrl, isActive];
}
