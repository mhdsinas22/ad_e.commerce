import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/brand/brand_bloc.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            // Responsive cross axis count:
            // Mobile  (< 600)  : 4 columns (unchanged)
            // Tablet  (600–1023): 6 columns
            // Desktop (≥ 1024) : 8 columns
            int crossAxisCount = 4;
            if (constraints.maxWidth >= 1024) {
              crossAxisCount = 8;
            } else if (constraints.maxWidth >= 600) {
              crossAxisCount = 6;
            }

            return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemCount: state.brands.length,
              itemBuilder: (context, index) {
                final brand = state.brands[index];
                final isSelected = state.selectedBrand == brand['name'];
                return GestureDetector(
                  onTap: () {
                    context.read<BrandBloc>().add(SelectBrand(brand['name']!));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.white,
                      border: Border.all(
                        color:
                            isSelected ? Colors.blue : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (brand['logo'] != null && brand['logo']!.isNotEmpty)
                          Expanded(
                            child: Image.asset(
                              brand['logo']!,
                              errorBuilder:
                                  (_, __, ___) => const Icon(
                                    Icons.phone_android,
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
