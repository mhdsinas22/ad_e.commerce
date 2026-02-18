import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/date_formatter.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_bloc.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_state.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/warranty_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/warranty_repositoryimpl.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/warranty.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Center(
            child: CircularArrowButton(
              iconSize: 20,
              size: 40,
              needCircle: true,
              iconColor: AppColors.pureBlack,
              icon: Icons.arrow_back,
              backgroundColor: const Color(0xFFF5F5F5),
              onTap: () => Navigator.pop(context),
            ),
          ),
          title: AppTexts.extraBold("Warranty", fontSize: 18),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: BlocBuilder<WarrantyBloc, WarrantyState>(
              builder: (context, state) {
                if (state.status == WarrantyStatus.loading) {
                  return _buildShimmerLoading();
                }

                if (state.status == WarrantyStatus.success) {
                  if (state.selectedWarranty == null) {
                    return const Center(child: Text("No Warranty Found"));
                  }
                  final warranty = state.selectedWarranty;
                  final today = DateUtils.dateOnly(DateTime.now());
                  final expiry = DateUtils.dateOnly(warranty!.expirydate);
                  final daysRemaining = expiry.difference(today).inDays;
                  final status = daysRemaining <= 0 ? "Expired" : "Active";
                  final displayText =
                      daysRemaining <= 0
                          ? "Expired"
                          : "$daysRemaining Days Remaining";
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.card != null)
                          // Digital Card
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: DigitalWarrantyCard(
                              warrantyCode: state.card!.warrantyCode,
                              status: status,
                            ),
                          ),

                        // Select Device Label
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AppTexts.medium(
                            "Select your Device:",
                            fontSize: 14,
                          ),
                        ),

                        // Dropdown
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DropdownButtonFormField<Warranty>(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: state.selectedWarranty,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            items:
                                state.warranties.map((warranty) {
                                  return DropdownMenuItem(
                                    value: warranty,
                                    child: Text(buildDropdownTitle(warranty)),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<WarrantyBloc>().add(
                                  SelectWarrantyEvent(value),
                                );
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Days Remaining
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppTexts.medium(
                            displayText,
                            fontSize: 18,
                            color:
                                daysRemaining <= 10
                                    ? AppColors.purered
                                    : Colors.black,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Dates
                        _buildDateRow(
                          "Purchase",
                          DateFormatter.formatDate(
                            warranty.startdate.toString(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildDateRow(
                          "Expires",
                          DateFormatter.formatDate(
                            warranty.expirydate.toString(),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Coverage Details Header
                        AppTexts.bold("Coverage Details", fontSize: 18),
                        const SizedBox(height: 12),

                        // Coverage Items
                        const CoverageItem(
                          text: "Hardware Defects",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text: "Battery < 80%",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text: "Battery < 80%",
                          isCovered: true,
                        ), // Duplicate in design? Keeping as is logic-wise but code had duplicates
                        const CoverageItem(
                          text: "Accidental Damage",
                          isCovered: false,
                        ),
                        const CoverageItem(
                          text: "Liquid Contact",
                          isCovered: false,
                        ),
                        const CoverageItem(
                          text: "Accidental Damage",
                          isCovered: false,
                        ),
                        const CoverageItem(
                          text: "Liquid Contact",
                          isCovered: false,
                        ),

                        const SizedBox(height: 32),

                        // Actions
                        PrimaryButton(
                          borderRadius: 12,
                          width: double.infinity,
                          height: 54,
                          text: "Request Repair / Claim",
                          backgroudColor: const Color(
                            0xFF0055FF,
                          ), // Brighter blue
                          fontcolor: Colors.white,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          needBorder: true,
                          borderColor: const Color(0xFF0055FF),
                          fontcolor: const Color(0xFF0055FF),
                          backgroudColor: Colors.white,
                          borderRadius: 12,
                          width: double.infinity,
                          height: 54,
                          text: "Renew Plans",
                          onPressed: () {},
                        ),

                        // Bottom Padding for safe area
                        const SizedBox(height: 20),
                      ],
                    ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          AppTexts.regular(
            "$label: ",
            fontSize: 14,
            color: const Color(0xFF666666),
          ),
          AppTexts.medium(date, fontSize: 14, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: 40),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Shimmer
            AppShimmer.rect(width: double.infinity, height: 220, radius: 24),
            const SizedBox(height: 24),
            // Dropdown Shimmer
            AppShimmer.rect(width: double.infinity, height: 50, radius: 12),
            const SizedBox(height: 16),
            // Days Remaining Shimmer
            Align(
              alignment: Alignment.centerRight,
              child: AppShimmer.rect(width: 150, height: 20, radius: 4),
            ),
            const SizedBox(height: 16),
            // Dates Shimmer
            AppShimmer.rect(width: 180, height: 16, radius: 4),
            const SizedBox(height: 8),
            AppShimmer.rect(width: 180, height: 16, radius: 4),
            const SizedBox(height: 24),
            // Coverage Header Shimmer
            AppShimmer.rect(width: 150, height: 24, radius: 4),
            const SizedBox(height: 12),
            // Coverage Items Shimmer
            for (int i = 0; i < 4; i++) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  AppShimmer.circle(size: 20),
                  const SizedBox(width: 12),
                  AppShimmer.rect(width: 200, height: 14, radius: 4),
                ],
              ),
            ],
            const SizedBox(height: 40),
            // Buttons Shimmer
            AppShimmer.rect(width: double.infinity, height: 54, radius: 12),
            const SizedBox(height: 12),
            AppShimmer.rect(width: double.infinity, height: 54, radius: 12),
          ],
        );
      },
    );
  }
}
