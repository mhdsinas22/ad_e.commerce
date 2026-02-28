import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';

class AirdropAssurance extends StatelessWidget {
  const AirdropAssurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.medium("AIRDROP Assurance", fontSize: 18),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  AssetConstants.aIRDROPAssuranceimg1,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Image.asset(
                  AssetConstants.aIRDROPAssuranceimg2,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  AssetConstants.aIRDROPAssuranceimg3,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Image.asset(
                  AssetConstants.aIRDROPAssuranceimg4,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
