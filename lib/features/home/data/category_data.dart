import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/features/home/models/category_model.dart';

class CategoryData {
  static List<CategoryModel> categories = [
    CategoryModel(title: "Phones", image: AssetConstants.phone),
    CategoryModel(title: "Accessories", image: AssetConstants.accesories),
    CategoryModel(title: "Laptop", image: AssetConstants.laptop),
    CategoryModel(title: "Tablet", image: AssetConstants.tablet),
    CategoryModel(title: "Wearables", image: AssetConstants.warables),
    CategoryModel(title: "Earbuds", image: AssetConstants.earbuds),
  ];
}
