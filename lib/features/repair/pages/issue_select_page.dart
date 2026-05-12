import 'package:aerstore/features/repair/bloc/issue/issue_bloc.dart';
import 'package:aerstore/features/repair/bloc/issue/issue_event.dart';
import 'package:aerstore/features/repair/bloc/issue/issue_state.dart';
import 'package:aerstore/features/repair/widgets/issue_radio_tile.dart';
import 'package:flutter/material.dart';
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
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 1024;
            final isTablet = constraints.maxWidth > 600;

            if (isDesktop) {
              // Desktop: 3-column grid of issue tiles
              return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 5.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                children: issues.map((issue) {
                  final isSelected = state.selectedIssues.contains(issue);
                  return IssueRadioLikeTile(
                    selected: isSelected,
                    title: issue,
                    onTap: () {
                      context.read<IssueBloc>().add(ToggleIssue(issue: issue));
                    },
                  );
                }).toList(),
              );
            } else if (isTablet) {
              // Tablet: 2-column grid of issue tiles
              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 5.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                children: issues.map((issue) {
                  final isSelected = state.selectedIssues.contains(issue);
                  return IssueRadioLikeTile(
                    selected: isSelected,
                    title: issue,
                    onTap: () {
                      context.read<IssueBloc>().add(ToggleIssue(issue: issue));
                    },
                  );
                }).toList(),
              );
            }

            // Mobile: original vertical list (unchanged)
            return Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: issues.map((issue) {
                  final isSelected = state.selectedIssues.contains(issue);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: IssueRadioLikeTile(
                      selected: isSelected,
                      title: issue,
                      onTap: () {
                        context.read<IssueBloc>().add(
                          ToggleIssue(issue: issue),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
