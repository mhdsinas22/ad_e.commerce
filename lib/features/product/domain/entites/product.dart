import 'package:ad_e_commerce/features/product/domain/entites/product_stock.dart';

class Product {
  final String? id;
  final String title;
  final String? description;
  final String category;
  final String condition; // pre_owned | brand_new
  final String conditionType;
  final String color;
  final double price;
  final double? originalPrice;
  final int? warrantyMonths;
  final bool isActive;
  final String modelNumber;
  final String storageid;
  final String storageName;
  final String ram;
  final String tag;
  final List<String> imageUrls;
  final List<ProductStock> stocks;

  Product({
    this.id,
    required this.title,
    this.description,
    required this.category,
    required this.condition,
    required this.color,
    required this.price,
    this.originalPrice,
    this.warrantyMonths,
    required this.conditionType,
    required this.isActive,
    required this.modelNumber,
    required this.storageid,
    required this.ram,
    required this.tag,
    required this.imageUrls,
    required this.stocks,
    required this.storageName,
  });
  bool get isFlashSale => tag.toLowerCase() == "Flash Sale";
}
