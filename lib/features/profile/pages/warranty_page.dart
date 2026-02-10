import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
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
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Center(
            child: CircularArrowButton(
              iconSize: 20,
              size: 40,
              needCircle: true,
              iconColor: AppColors.pureBlack,
              icon: Icons.arrow_back,
              backgroundColor: AppColors.lightGrey,
              onTap: () => Navigator.pop(context),
            ),
          ),
          title: AppTexts.extraBold("Warranty", fontSize: 16),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: BlocBuilder<WarrantyBloc, WarrantyState>(
              builder: (context, state) {
                if (state.status == WarrantyStatus.loading) {
                  return _buildShimmerLoading();
                }

                if (state.status == WarrantyStatus.success) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    itemCount: state.warranties.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 30),
                    itemBuilder: (context, index) {
                      final warranty = state.warranties[index];
                      final todayDateOnly = DateUtils.dateOnly(DateTime.now());
                      final expiryDateOnly = DateUtils.dateOnly(
                        warranty.expiryDate,
                      );

                      final daysRemaining =
                          expiryDateOnly.difference(todayDateOnly).inDays;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Digital Card
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: DigitalWarrantyCard(
                              warrantyCode: warranty.warrantyCode,
                              status: daysRemaining <= 0 ? "EXPIRED" : "ACTIVE",
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Days Remaining
                          Align(
                            alignment: Alignment.centerRight,
                            child: AppTexts.medium(
                              "$daysRemaining Days Remaining",
                              fontSize: 16,
                              color:
                                  daysRemaining <= 10
                                      ? AppColors
                                          .purered // Assuming typo fix: pureRed
                                      : AppColors.pureBlack,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Dates
                          _buildDateRow(
                            "Purchase",
                            DateFormatter.formatDate(
                              warranty.startDate.toString(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDateRow(
                            "Expires",
                            DateFormatter.formatDate(
                              warranty.expiryDate.toString(),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Coverage Details Header
                          AppTexts.bold("Coverage Details", fontSize: 16),
                          const SizedBox(height: 12),

                          // Coverage Items
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

                          const SizedBox(height: 40),

                          // Actions
                          PrimaryButton(
                            borderRadius: 12,
                            width: double.infinity,
                            height: 50,
                            text: "Request Repair / Claim",
                            onPressed: () {},
                          ),
                          const SizedBox(height: 12),
                          PrimaryButton(
                            needBorder: true,
                            borderColor: AppColors.primaryBlue,
                            fontcolor: AppColors.primaryBlue,
                            backgroudColor: AppColors.pureWhite,
                            borderRadius: 12,
                            width: double.infinity,
                            height: 50,
                            text: "Renew Plans",
                            onPressed: () {},
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(String label, String date) {
    return Row(
      children: [
        AppTexts.regular("$label: ", fontSize: 14, color: Colors.grey.shade600),
        AppTexts.medium(date, fontSize: 14),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: 40),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Shimmer
            AppShimmer.rect(width: double.infinity, height: 217, radius: 16),
            const SizedBox(height: 16),
            // Days Remaining Shimmer
            Align(
              alignment: Alignment.centerRight,
              child: AppShimmer.rect(width: 150, height: 20, radius: 4),
            ),
            const SizedBox(height: 24),
            // Dates Shimmer
            AppShimmer.rect(width: 200, height: 16, radius: 4),
            const SizedBox(height: 8),
            AppShimmer.rect(width: 200, height: 16, radius: 4),
            const SizedBox(height: 30),
            // Coverage Header Shimmer
            AppShimmer.rect(width: 150, height: 20, radius: 4),
            const SizedBox(height: 12),
            // Coverage Items Shimmer
            for (int i = 0; i < 4; i++) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  AppShimmer.circle(size: 20),
                  const SizedBox(width: 8),
                  AppShimmer.rect(width: 150, height: 14, radius: 4),
                ],
              ),
            ],
            const SizedBox(height: 40),
            // Buttons Shimmer
            AppShimmer.rect(width: double.infinity, height: 50, radius: 12),
            const SizedBox(height: 12),
            AppShimmer.rect(width: double.infinity, height: 50, radius: 12),
          ],
        );
      },
    );
  }
}
