class ProductWarranty {
  final String? id;
  final String productId;
  final String warrantyTypeId;
  final DateTime startDate;
  final DateTime endDate;
  final String durationText;

  const ProductWarranty({
    this.id,
    required this.productId,
    required this.warrantyTypeId,
    required this.startDate,
    required this.endDate,
    required this.durationText,
  });
}
