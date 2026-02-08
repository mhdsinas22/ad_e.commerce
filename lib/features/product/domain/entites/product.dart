import 'package:ad_e_commerce/features/product/domain/entites/product_stock.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product_warranty.dart';

class Product {
  final String? id;
  final String title;
  final String? description;
  final String category;
  final String condition; // pre_owned | brand_new
  final String conditionType;
  final String colorid;
  final String color;
  final double price;
  final double? originalPrice;
  final int? warrantyMonths;
  final bool isActive;
  final String modelNumber;
  final String storageid;
  final String ramid;
  final String ram;
  final String tag;
  final String storage;
  final List<String> imageUrls;
  final List<ProductStock> stocks;
  final String categoryid;
  final String conditiontypeid;
  final double rating;
  final int noofreviews;
  final String subCategory;
  final List<ProductWarranty> warranties;

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
    required this.ramid,
    required this.ram,
    required this.tag,
    required this.imageUrls,
    required this.stocks,
    required this.storage,
    required this.colorid,
    required this.categoryid,
    required this.conditiontypeid,
    required this.rating,
    required this.noofreviews,
    required this.subCategory,
    this.warranties = const [],
  });
}
