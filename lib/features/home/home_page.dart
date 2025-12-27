import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/core/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          AssetConstants.airdropLetterLogo,
          width: 125,
          height: 57,
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, RouteNames.cart),
            child: SvgPicture.asset(AssetConstants.carticonpng),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: AppTextFormField(
                  width: 380,
                  borderradiusno: 10,
                  hintText: "Search...",
                  suffixIcon: Icon(Icons.search, color: AppColors.grayColor),
                ),
              ),
              Image.asset(AssetConstants.demoimage),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryCard(title: "Phone", image: AssetConstants.phone),
                  CategoryCard(
                    title: "Accesories",
                    image: AssetConstants.accesories,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryCard(
                    width: 78,
                    height: 80,
                    title: "Laptop",
                    image: AssetConstants.laptop,
                  ),
                  CategoryCard(
                    width: 78,
                    height: 80,
                    title: "Tablet",
                    image: AssetConstants.tablet,
                  ),
                  CategoryCard(
                    width: 78,
                    height: 80,
                    title: "Wearable",
                    image: AssetConstants.warables,
                  ),
                  CategoryCard(
                    width: 78,
                    height: 80,
                    title: "Earbuds",
                    image: AssetConstants.earbuds,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTexts.medium("Flash Sale", fontSize: 18),
                  AppTexts.medium(
                    "View All",
                    fontSize: 12,
                    color: AppColors.primaryBlue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
