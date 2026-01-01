import 'package:ad_e_commerce/features/repair/bloc/issue/issue_event.dart';
import 'package:ad_e_commerce/features/repair/bloc/issue/issue_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueBloc() : super(IssueState(selectedIssue: "Screen")) {
    on<IssueSelected>((event, emit) {
      emit(IssueState(selectedIssue: event.issue));
    });
  }
}
