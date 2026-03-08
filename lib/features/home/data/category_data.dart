import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/features/home/models/category_model.dart';

class CategoryData {
  static List<CategoryModel> categories = [
    CategoryModel(
      title: "iPhone",
      image: AssetConstants.iphoneCategorypng,
      type: "phoneCategory",
    ),
    CategoryModel(
      title: "Accessories",
      image: AssetConstants.accessoriescatpng,
      type: "accessoriesCategory",
    ),
    CategoryModel(
      title: "Laptop",
      image: AssetConstants.laptopCategoryPng,
      type: "laptopCategory",
    ),
    CategoryModel(
      title: "Tablet",
      image: AssetConstants.tablet,
      type: "tabletCategory",
    ),
    CategoryModel(
      title: "Wearables",
      image: AssetConstants.wearablescatergorypng,
      type: "wearablesCategory",
    ),
    CategoryModel(
      title: "Earbuds",
      image: AssetConstants.earbuds,
      type: "earbudsCategory",
    ),
  ];
}
