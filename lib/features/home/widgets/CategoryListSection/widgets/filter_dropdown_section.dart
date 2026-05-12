import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/custom_dropdown.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_event.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDropdownSection extends StatelessWidget {
  final bool showConditionDropdown;
  final bool showWarrantyDropdown;
  final int finallistLength;
  const FilterDropdownSection({
    super.key,
    required this.showConditionDropdown,
    required this.showWarrantyDropdown,
    required this.finallistLength,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Condtion DropDown
              if (showConditionDropdown)
                CustomDropdown(
                  hintText: "Select Condition",
                  value:
                      state.selectedCondition == "Select Condition"
                          ? null
                          : state.selectedCondition,
                  items: const ["Brand New", "Pre-Owned"],
                  onChanged: (value) {
                    context.read<ProductBloc>().add(
                      UpdateConditionFilter(value!),
                    );
                  },
                ),
              // Warranty DropDown
              if (showWarrantyDropdown)
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return CustomDropdown(
                      hintText: "Choose Warranty",
                      value:
                          state.selectedWarranty == "Choose Warranty"
                              ? null
                              : state.selectedWarranty,
                      items: const ["Apple Warranty", "Shop Warranty"],
                      onChanged: (value) {
                        context.read<ProductBloc>().add(
                          UpdateWarrantyFilter(value!),
                        );
                      },
                    );
                  },
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10.0,
                ),
                child: AppTexts.medium(
                  "Result: $finallistLength Items Found",
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
