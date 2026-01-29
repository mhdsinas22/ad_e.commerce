import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/features/home/models/category_model.dart';

class CategoryData {
  static List<CategoryModel> categories = [
    CategoryModel(
      title: "Phones",
      image: AssetConstants.phone,
      type: "phoneCategory",
    ),
    CategoryModel(
      title: "Accessories",
      image: AssetConstants.accesories,
      type: "accessoriesCategory",
    ),
    CategoryModel(
      title: "Laptop",
      image: AssetConstants.laptop,
      type: "laptopCategory",
    ),
    CategoryModel(
      title: "Tablet",
      image: AssetConstants.tablet,
      type: "tabletCategory",
    ),
    CategoryModel(
      title: "Wearables",
      image: AssetConstants.warables,
      type: "wearablesCategory",
    ),
    CategoryModel(
      title: "Earbuds",
      image: AssetConstants.earbuds,
      type: "earbudsCategory",
    ),
  ];
}
