import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/brand/brand_bloc.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
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
                      isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ideally use Image.asset, but fallbacking to Icon/Text if missing
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
                      )
                    else
                      const Icon(Icons.phone_android, color: Colors.grey),
                    const SizedBox(height: 4),
                    Text(
                      brand['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
