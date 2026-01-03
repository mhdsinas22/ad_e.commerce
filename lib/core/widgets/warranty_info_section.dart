import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class WarrantyInfoSection extends StatefulWidget {
  const WarrantyInfoSection({super.key});

  @override
  State<WarrantyInfoSection> createState() => _WarrantyInfoSectionState();
}

class _WarrantyInfoSectionState extends State<WarrantyInfoSection> {
  bool faqOpen = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.brightBlue, // same blue
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HOW TO CLAIM WARRANTY
          AppTexts.medium(
            "How to Claim Warranty",
            fontSize: 20,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            "To claim warranty, send a message to our WhatsApp number with your order ID and issue details.",
            style: const TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 24),

          /// WHY AIRDROP
          AppTexts.medium("Why AIRDROP", fontSize: 18, color: Colors.white),
          const SizedBox(height: 16),

          _whyItem(Icons.handshake_outlined, "Premium Repair Quality"),
          _whyItem(Icons.verified_outlined, "6-Month Service Warranty"),
          _whyItem(Icons.build_outlined, "Skilled Technicians"),
          _whyItem(Icons.security_outlined, "Guaranteed Data Safety"),

          const SizedBox(height: 24),

          /// FAQ TITLE
          AppTexts.medium(
            "FREQUENTLY ASKED QUESTIONS",
            fontSize: 16,
            color: Colors.white,
          ),
          const Divider(color: Colors.white30),

          /// FAQ ITEM
          GestureDetector(
            onTap: () {
              setState(() => faqOpen = !faqOpen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Where can I watch?",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Icon(faqOpen ? Icons.close : Icons.add, color: Colors.white),
              ],
            ),
          ),

          if (faqOpen) ...[
            const SizedBox(height: 12),
            const Text(
              "Nibh quisque suscipit fermentum netus nulla cras porttitor euismod nulla. Orci, dictumst nec aliquet id ullamcorper venenatis.",
              style: TextStyle(color: Colors.white70),
            ),
          ],

          const Divider(color: Colors.white30),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Mauris id nibh eu fermentum mattis purus?",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Icon(Icons.add, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _whyItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
