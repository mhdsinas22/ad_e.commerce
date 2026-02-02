import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/features/home/models/category_model.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';
import 'package:flutter/material.dart';

class Helpers {
  Helpers._();
  static Future<void> delay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  static String conditionToString(PhoneCondition condition) {
    switch (condition) {
      case PhoneCondition.brandNew:
        return "BRAND NEW";
      case PhoneCondition.preOwned:
        return "PRE-OWNED";
      case PhoneCondition.empty:
        return "";
    }
  }

  static String categoryToString(Category category) {
    switch (category) {
      case Category.phones:
        return "Phones";
      case Category.accessories:
        return "accessories";
      case Category.earbuds:
        return "Earbuds";
      case Category.laptop:
        return "Laptop";
      case Category.wearables:
        return "Wearables";
      case Category.tablet:
        return "Tablet";
      case Category.empty:
        return "";
    }
  }

  static String subCategoryToString(SubCategory subCategory) {
    switch (subCategory) {
      case SubCategory.macbook:
        return "Apple Macbook";
      case SubCategory.windows:
        return "Windows Laptop";
      case SubCategory.appleairpods:
        return "Apple AirPods";
      case SubCategory.earbuds:
        return "Earbuds";
      case SubCategory.appleipad:
        return "Apple iPad";
      case SubCategory.applewatch:
        return "Apple iWatch";
      case SubCategory.smartwatch:
        return "Smart Watch";
      case SubCategory.tab:
        return "Android Tablet";
      case SubCategory.empty:
        return "";
      case SubCategory.casescover:
        return "Cases & Cover";
      case SubCategory.mobilechargers:
        return "Mobile Charger";
      case SubCategory.speaker:
        return "Speaker";
      case SubCategory.audio:
        return "Headsets";
      case SubCategory.powerbank:
        return "Power Bank";
      case SubCategory.bag:
        return "Bag";
    }
  }
}

Map<String, String> splitWarrantyCode(String code) {
  String letters = '';
  String numbers = '';

  for (int i = 0; i < code.length; i++) {
    if (RegExp(r'[A-Z]').hasMatch(code[i])) {
      letters += code[i];
    } else if (RegExp(r'[0-9]').hasMatch(code[i])) {
      numbers += code[i];
    }
  }

  return {'letters': letters, 'numbers': numbers};
}

void handleNavigation(BuildContext context, CategoryModel item) {
  switch (item.type) {
    case "phoneCategory":
      Appnavigotor.pushnamed(context, RouteNames.phonecategories, {});
      break;
    case "accessoriesCategory":
      Appnavigotor.pushnamed(context, RouteNames.accessoriescategories, {});
      break;
    case "earbudsCategory":
      Appnavigotor.pushnamed(context, RouteNames.earbudsCategories, {});
      break;
    case "laptopCategory":
      Appnavigotor.pushnamed(context, RouteNames.laptopcategories, {});
      break;
    case "wearablesCategory":
      Appnavigotor.pushnamed(context, RouteNames.wearablescategories, {});
      break;
    case "tabletCategory":
      Appnavigotor.pushnamed(context, RouteNames.tabletcategories, {});
      break;
  }
}
