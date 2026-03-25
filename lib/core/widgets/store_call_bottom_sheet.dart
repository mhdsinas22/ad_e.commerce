import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class StoreCallBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 241,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTexts.medium(
                  fontSize: 16,
                  align: TextAlign.center,
                  "Call our Authorized Store\nfor plan Renewal",
                ),
                const SizedBox(height: 20),

                /// 🔹 Malappuram
                PrimaryButton(
                  width: 184,
                  borderRadius: 12,
                  text: "Malappuram",
                  onPressed: () {
                    Helpers.makePhoneCall("+917510506060");
                  },
                ),

                const SizedBox(height: 10),

                /// 🔹 Calicut
                PrimaryButton(
                  width: 184,
                  borderRadius: 12,
                  text: "Calicut",
                  onPressed: () {
                    Helpers.makePhoneCall("+917511166623");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
