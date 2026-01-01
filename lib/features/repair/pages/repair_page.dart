import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/core/widgets/multiline_input_field.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_bloc.dart';
import 'package:ad_e_commerce/features/repair/bloc/repairImage/repair_image_bloc.dart';
import 'package:ad_e_commerce/features/repair/pages/issue_select_page.dart';
import 'package:ad_e_commerce/features/repair/widgets/repair_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RepairPage extends StatelessWidget {
  const RepairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IssueBloc()),
        BlocProvider(create: (context) => RepairImageBloc()),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            AppSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 12.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Select Brand", fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Select Services", fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium(
                        "(Tap to select multiple issues)",
                        fontSize: 10,
                      ),
                    ),
                  ),

                  IssueSelectPage(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium(
                        "Reapair Request Form",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonFormField(
                      items: [],
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: AppColors.lightGrey),
                        hintText: "iphone 13",
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(59.29),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium(
                        "Complaint Description:",
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: MultilineInputField(
                      controller: TextEditingController(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Upload Photo", fontSize: 12),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RepairImagePicker(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium(" Your Details: ", fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Name: ", fontSize: 12),
                    ),
                  ),
                  AppTextFormField(width: 345, height: 45, hintText: "Email"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Mobile: ", fontSize: 12),
                    ),
                  ),
                  AppTextFormField(width: 345, height: 45, hintText: "Email"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Email: ", fontSize: 12),
                    ),
                  ),
                  AppTextFormField(width: 345, height: 45, hintText: "Email"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AppTexts.medium("Location:", fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonFormField(
                      items: [DropdownMenuItem(child: Text("Malappuram"))],
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: AppColors.lightGrey),

                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(59.29),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8,
                    ),
                    child: PrimaryButton(
                      width: 110,
                      height: 32,
                      fontsize: 12,
                      text: "Submit",

                      onPressed: () {},
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      AssetConstants.airwarrntyrepair,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
