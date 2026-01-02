import 'package:ad_e_commerce/features/repair/bloc/issue/issue_event.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueBloc() : super(IssueState()) {
    on<ToggleIssue>((event, emit) {
      final current = List<String>.from(state.selectedIssues);
      if (current.contains(event.issue)) {
        current.remove(event.issue);
      } else {
        current.add(event.issue);
      }
      emit(state.copyWith(selectedIssues: current));
    });
  }
}
