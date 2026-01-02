class IssueState {
  final List<String> selectedIssues;

  const IssueState({this.selectedIssues = const []});
  IssueState copyWith({List<String>? selectedIssues}) {
    return IssueState(selectedIssues: selectedIssues ?? this.selectedIssues);
  }
}
