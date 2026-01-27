import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/date_formatter.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_bloc.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_state.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/warranty_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/warranty_repositoryimpl.dart';
import 'package:ad_e_commerce/features/profile/widgets/coverage_item.dart';
import 'package:ad_e_commerce/features/profile/widgets/warranty_digital_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WarrantyPage extends StatelessWidget {
  const WarrantyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabse = Supabase.instance.client;
    final warrantyRepositoryimpl = WarrantyRepositoryimpl(
      WarrantyRemoteDatasourceimpl(supabse),
    );
    return BlocProvider(
      create:
          (context) =>
              WarrantyBloc(warrantyRepositoryimpl)..add(LoadWarrantiesEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularArrowButton(
              iconSize: 25,
              size: 100,
              needCircle: true,
              iconColor: AppColors.pureBlack,
              icon: Icons.arrow_back,
              backgroundColor: AppColors.lightGrey,
              onTap: () => Navigator.pop(context),
            ),
          ),
          title: AppTexts.extraBold("Warranty", fontSize: 14),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            BlocBuilder<WarrantyBloc, WarrantyState>(
              builder: (context, state) {
                if (state.status == WarrantyStatus.loading) {
                  return const CircularProgressIndicator();
                }

                if (state.status == WarrantyStatus.success) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.warranties.length,
                    itemBuilder: (context, index) {
                      final warranty = state.warranties[index];
                      DateTime today = DateTime.now();
                      DateTime todayDateOnly = DateTime(
                        today.year,
                        today.month,
                        today.day,
                      );

                      DateTime expiryDateOnly = DateTime(
                        warranty.expiryDate.year,
                        warranty.expiryDate.month,
                        warranty.expiryDate.day,
                      );

                      int daysRemaining =
                          expiryDateOnly.difference(todayDateOnly).inDays;

                      return Column(
                        children: [
                          DigitalWarrantyCard(
                            warrantyCode: warranty.warrantyCode,
                            status: daysRemaining <= 0 ? "EXPIRED" : "ACTIVE",
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: AppTexts.medium(
                                "$daysRemaining Days Remaining",
                                fontSize: 18,
                                color:
                                    daysRemaining <= 10
                                        ? AppColors.purered
                                        : AppColors.pureBlack,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: AppTexts.medium(
                                "Purchase:${DateFormatter.formatDate(warranty.startDate.toString())}",
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 4,
                              ),
                              child: AppTexts.medium(
                                "Expires: ${DateFormatter.formatDate(warranty.expiryDate.toString())}",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: AppTexts.medium(
                                "Coverage Details",
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CoverageItem(
                                text: "Hardware Defects",
                                isCovered: true,
                              ),
                              CoverageItem(
                                text: "Battery < 80%",
                                isCovered: true,
                              ),
                              CoverageItem(
                                text: "Accidental Damage",
                                isCovered: false,
                              ),
                              CoverageItem(
                                text: "Liquid Contact",
                                isCovered: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: PrimaryButton(
                              borderRadius: 10,
                              width: double.infinity,
                              height: 50,
                              text: "Request Repair / Claim",
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: PrimaryButton(
                              needBorder: true,
                              borderColor: AppColors.primaryBlue,
                              fontcolor: AppColors.primaryBlue,
                              backgroudColor: AppColors.pureWhite,
                              borderRadius: 10,
                              width: double.infinity,
                              height: 50,
                              text: "Renew Plans",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
