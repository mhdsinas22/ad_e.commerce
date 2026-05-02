import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarw extends StatefulWidget {
  final bool isNeedSearchFocus;
  const SearchBarw({super.key, this.isNeedSearchFocus = true});

  @override
  State<SearchBarw> createState() => _SearchBarwState();
}

class _SearchBarwState extends State<SearchBarw> {
  final FocusNode searchFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AppTextFormField(
          focusNode: widget.isNeedSearchFocus ? searchFocus : null,
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
