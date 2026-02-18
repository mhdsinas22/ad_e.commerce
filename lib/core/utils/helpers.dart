import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/features/home/models/category_model.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/warranty.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      case SubCategory.fresh:
        return "Fresh";
      case SubCategory.second:
        return "Second";
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  static Future<void> openStoreLocation(String link) async {
    final Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open map");
    }
  }

  static Future<void> openWhatsapp(String phoneNumber) async {
    final Uri url = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not open WhatsApp");
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

String buildDropdownTitle(Warranty warranty) {
  final raw = warranty.product;

  // Extract type
  final typeMatch = RegExp(r'type:\s*([^,}]+)').firstMatch(raw);
  final type = typeMatch?.group(1)?.trim();

  if (type == "order") {
    final nameMatch = RegExp(r'product_name:\s*([^,}]+)').firstMatch(raw);
    final orderMatch = RegExp(r'order_number:\s*([^,}]+)').firstMatch(raw);

    final name = nameMatch?.group(1)?.trim() ?? "Unknown";
    final order = orderMatch?.group(1)?.trim() ?? "";

    return "$name ($order)";
  }

  if (type == "repair") {
    final nameMatch = RegExp(r'device_model:\s*([^,}]+)').firstMatch(raw);
    final repairMatch = RegExp(r'repair_code:\s*([^,}]+)').firstMatch(raw);

    final name = nameMatch?.group(1)?.trim() ?? "Unknown";
    final repair = repairMatch?.group(1)?.trim() ?? "";

    return "$name ($repair)";
  }

  return raw;
}
