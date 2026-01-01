import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IssueRadioTile extends StatelessWidget {
  final String value;
  final String title;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  const IssueRadioTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      dense: true,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(title),
      activeColor: AppColors.pureBlack,
      visualDensity: const VisualDensity(vertical: -4),
    );
  }
}
