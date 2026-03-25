import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/product/widgets/product_image_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AirdropAssurance extends StatefulWidget {
  final bool isProductPage;
  const AirdropAssurance({super.key, this.isProductPage = false});

  @override
  State<AirdropAssurance> createState() => _AirdropAssuranceState();
}

class _AirdropAssuranceState extends State<AirdropAssurance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          widget.isProductPage
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.medium("AER Assurance", fontSize: 18),
          const SizedBox(height: 16),
          FutureBuilder(
            future: Supabase.instance.client.from("aerassurance").select(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return AppShimmer.banner();
              }

              final data = snapshot.data as List;
              final imageUrl =
                  data[0]["cmsimageassurance"]
                      .toString()
                      .replaceAll('"', '')
                      .trim();
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ProductImageCarousel(
                    isNeedBanner: true,
                    images: [imageUrl],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
