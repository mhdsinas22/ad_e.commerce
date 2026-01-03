import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IssueRadioLikeTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const IssueRadioLikeTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            // 🔘 Radio look
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.grayColor : Colors.grey,
                  width: 2,
                ),
              ),
              child:
                  selected
                      ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.pureBlack,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
}
