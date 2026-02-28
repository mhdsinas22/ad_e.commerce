import 'package:ad_e_commerce/core/constants/app_constants.dart';
import 'package:ad_e_commerce/core/enums/category.dart';
import 'package:ad_e_commerce/core/enums/phone_condition.dart';
import 'package:ad_e_commerce/core/enums/sub_category.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_state.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';

class ProductFilterService {
  static List<Product> applyFilters({
    required List<Product> products,
    required ProductState state,
    required String query,
    required PhoneCondition condition,
    required Category category,
    required SubCategory subCategory,
    required bool isSubCategory,
    required bool isFlashSale,
    required bool isBestSeller,
    required bool onlyPhones,
    required int? priceAmount,
    required String? priceType,
  }) {
    return products.where((product) {
      /// 🔹 Normal condition filter
      final matchCondition =
          condition == PhoneCondition.empty ||
          product.condition == Helpers.conditionToString(condition);

      /// 🔹 Category filter
      final matchCategory =
          category == Category.empty ||
          product.category == Helpers.categoryToString(category);

      /// 🔹 Subcategory filter
      final matchSubCategory =
          !isSubCategory ||
          product.subCategory == Helpers.subCategoryToString(subCategory);

      /// 🔹 Flash sale
      final matchFlashSale = !isFlashSale || product.tag == "Flash Sale";

      /// 🔹 Best seller
      final matchBestSeller = !isBestSeller || product.tag == "Best Seller";

      /// 🔹 Price filter
      final matchPrice =
          priceAmount == null
              ? true
              : priceType == "Under"
              ? product.price <= priceAmount
              : product.price >= priceAmount;

      /// 🔹 Only Phones filter (MISSING BEFORE)
      final matchPhoneCategory = !onlyPhones || product.category == "Phones";

      /// 🔹 Dropdown Condition filter (MISSING BEFORE)
      PhoneCondition? dropdownConditionEnum;

      if (state.selectedCondition == "Brand New") {
        dropdownConditionEnum = PhoneCondition.brandNew;
      } else if (state.selectedCondition == "Pre-Owned") {
        dropdownConditionEnum = PhoneCondition.preOwned;
      } else {
        dropdownConditionEnum = null;
      }

      final matchDropdownCondition =
          dropdownConditionEnum == null
              ? true
              : product.condition ==
                  Helpers.conditionToString(dropdownConditionEnum);

      /// 🔹 Warranty filter (MISSING BEFORE)
      final matchWarranty =
          state.selectedWarranty == null ||
                  state.selectedWarranty == "Choose Warranty"
              ? true
              : state.selectedWarranty == "Apple Warranty"
              ? product.warranties.any(
                (w) => w.warrantyTypeId.toString() == WarrantyTypeIds.apple,
              )
              : state.selectedWarranty == "Shop Warranty"
              ? product.warranties.any(
                (w) => w.warrantyTypeId.toString() == WarrantyTypeIds.shop,
              )
              : true;

      /// 🔹 Search filter
      final matchSearch =
          query.isEmpty ||
          product.title.toLowerCase().contains(query) ||
          product.price.toString().contains(query);

      return matchCondition &&
          matchCategory &&
          matchSubCategory &&
          matchFlashSale &&
          matchBestSeller &&
          matchPrice &&
          matchPhoneCategory &&
          matchDropdownCondition &&
          matchWarranty &&
          matchSearch;
    }).toList();
  }
}
