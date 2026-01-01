abstract class IssueEvent {}

class IssueSelected extends IssueEvent {
  final String issue;
  IssueSelected({required this.issue});
}
