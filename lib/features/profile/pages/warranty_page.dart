import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/date_formatter.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/core/widgets/store_call_bottom_sheet.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_bloc.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/warranty/warranty_state.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/warranty_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/warranty_repositoryimpl.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/warranty.dart';
import 'package:ad_e_commerce/features/profile/widgets/coverage_item.dart';
import 'package:ad_e_commerce/features/profile/widgets/warranty_digital_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => BottomNavBloc()),
        BlocProvider(
          create:
              (context) =>
                  WarrantyBloc(warrantyRepositoryimpl)
                    ..add(LoadWarrantiesEvent()),
        ),
      ],

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
              onTap: () => context.pop(),
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
                        Row(
                          children: [
                            AppTexts.regular("Coverage Type:", fontSize: 16),
                            AppTexts.regular(
                              warranty.coverageType ?? "",
                              fontSize: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
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
                        AppTexts.extraBold(
                          "AER Service Coverage & Benefits",
                          fontSize: 18,
                        ),
                        const SizedBox(height: 16),

                        // Device Hardware Coverage
                        AppTexts.bold("Device Hardware Coverage", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text: "Ear Speaker, Loudspeaker & Microphone",
                          isCovered: true,
                        ),
                        const CoverageItem(text: "Charging Port", isCovered: true),
                        const CoverageItem(text: "Vibration Motor", isCovered: true),
                        const CoverageItem(
                          text: "All Device Buttons (Power, Volume, etc.)",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text: "Back Camera Glass",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text: "Proximity Sensors",
                          isCovered: true,
                        ),
                        const CoverageItem(text: "SIM Tray", isCovered: true),
                        const CoverageItem(
                          text: "Internal Antennas (Wi-Fi & Bluetooth)",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text: "Internal Screws and Brackets",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Biometric & Security Features
                        AppTexts.bold("Biometric & Security Features", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text:
                              "Face ID / Touch ID (Applicable only for non-physical damage issues)",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Battery Support
                        AppTexts.bold("Battery Support", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text: "Battery warranty valid for 6 months from purchase",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text:
                              "Eligible for replacement if battery health drops below 80% within warranty period",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text:
                              "Post-warranty offer: 30% discount on battery replacement after 6 months",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Software & Performance
                        AppTexts.bold("Software & Performance", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text: "Software warranty coverage for 6 months from purchase",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Service Quality Assurance
                        AppTexts.bold("Service Quality Assurance", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text:
                              "Air-tight packing after every service to ensure device safety",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text:
                              "Free Health Check & Cleaning Service 2 time within 6 months",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Customer Protection Benefits
                        AppTexts.bold("Customer Protection Benefits", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text: "2-Month Replacement Warranty for defective devices",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text:
                              "Accidental Damage Protection: No service charge (customer pays only for spare parts)",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Buy-Back Guarantee
                        AppTexts.bold("Buy-Back Guarantee", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text: "Valid for 6 months from purchase",
                          isCovered: true,
                        ),
                        const CoverageItem(
                          text: "Assured 70% buy-back value",
                          isCovered: true,
                        ),

                        const SizedBox(height: 16),
                        // Additional Support
                        AppTexts.bold("Additional Support", fontSize: 16),
                        const SizedBox(height: 8),
                        const CoverageItem(
                          text:
                              "Complimentary spare phone provided during service period for your convenience",
                          isCovered: true,
                        ),

                        const SizedBox(height: 24),
                        // Service Exclusions Header
                        AppTexts.extraBold(
                          "Service Exclusions & Limitations",
                          fontSize: 18,
                        ),
                        const SizedBox(height: 16),

                        AppTexts.bold("Accidental Damage:", fontSize: 15),
                        const CoverageItem(
                          text:
                              "Warranty does not cover damages caused by accidental drops, liquid exposure, or external impact. (Applicable under Customer Protection Benefits)",
                          isCovered: true,
                        ),

                        const SizedBox(height: 8),
                        AppTexts.bold("Tampering / Seal Violation:", fontSize: 15),
                        const CoverageItem(
                          text:
                              "Warranty will be void if the device seal is broken or the official AER monogram sticker is removed or tampered with.",
                          isCovered: true,
                        ),

                        const SizedBox(height: 8),
                        AppTexts.bold("Manufacturer Warranty Claims:", fontSize: 15),
                        const CoverageItem(
                          text:
                              "Any claims under the brand's authorized warranty will be handled exclusively by the respective authorized service center. AER holds no responsibility or involvement in such cases.",
                          isCovered: true,
                        ),

                        const SizedBox(height: 32),

                        // Actions
                        PrimaryButton(
                          borderRadius: 12,
                          width: double.infinity,
                          height: 54,
                          text: "Request Repair / Claim",
                          backgroudColor: AppColors.primaryBlack,
                          fontcolor: Colors.white,
                          onPressed: () {
                            final bottomNavBloc = context.read<BottomNavBloc>();
                            bottomNavBloc.add(BottomNavChanged(index: 3));
                            context.pop();
                          },
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          needBorder: true,
                          borderColor: AppColors.primaryBlack,
                          fontcolor: AppColors.primaryBlack,
                          backgroudColor: Colors.white,
                          borderRadius: 12,
                          width: double.infinity,
                          height: 54,
                          text: "Renew Plans",
                          onPressed: () {
                            StoreCallBottomSheet.show(context);
                          },
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
