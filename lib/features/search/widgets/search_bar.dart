import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarw extends StatelessWidget {
  const SearchBarw({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AppTextFormField(
          onChanged: (value) {
            context.read<SearchBloc>().add(SerachTextChanged(query: value));
          },
          width: double.infinity,
          borderradiusno: 12,
          hintText: "Search...",
          suffixIcon: const Icon(Icons.search, color: AppColors.grayColor),
        ),
      ),
    );
  }
}
