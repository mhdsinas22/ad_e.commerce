abstract class IssueEvent {}

class ToggleIssue extends IssueEvent {
  final String issue;
  ToggleIssue({required this.issue});
}
