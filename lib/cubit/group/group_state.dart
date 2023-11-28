part of 'group_cubit.dart';

sealed class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

final class GroupInitial extends GroupState {}

final class GroupLoading extends GroupState {}

final class GroupError extends GroupState {
  final String groupErrorMessage;
  const GroupError(this.groupErrorMessage);
}

class GroupLoaded extends GroupState {
  final List<GroupModel> group;
  const GroupLoaded(this.group);
}
