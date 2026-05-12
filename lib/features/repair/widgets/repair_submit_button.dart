import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/repair_form/repair_form_bloc.dart';

class RepairSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RepairSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairFormBloc, RepairFormState>(
      builder: (context, state) {
        if (state.status == FormStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlack),
          );
        }
        return SizedBox(
          width: 110,
          height: 32,
          child: PrimaryButton(
            onPressed: onPressed,
            text: "Submit",
            fontsize: 12,
            borderRadius: 36,
          ),
        );
      },
    );
  }
}
