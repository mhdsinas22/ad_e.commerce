import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
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

      body: Column(
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
        ],
      ),
    );
  }
}
