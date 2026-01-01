import 'package:ad_e_commerce/features/repair/bloc/issue/issue_bloc.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_event.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_state.dart';
import 'package:ad_e_commerce/features/repair/widgets/issue_radio_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueSelectPage extends StatelessWidget {
  const IssueSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final issues = [
      "Screen",
      "Charging",
      "Water Damage",
      "Battery",
      "Camera",
      "Software",
      "Mic/Audio",
      "Back Panel",
      "Cleaning",
    ];

    return BlocBuilder<IssueBloc, IssueState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topLeft,
          child: Column(
            children:
                issues.map((issue) {
                  return IssueRadioTile(
                    title: issue,
                    value: issue,
                    groupValue: state.selectedIssue,
                    onChanged: (value) {
                      context.read<IssueBloc>().add(
                        IssueSelected(issue: value!),
                      );
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
