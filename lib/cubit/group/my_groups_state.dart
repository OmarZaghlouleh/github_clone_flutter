part of 'my_groups_cubit.dart';

sealed class MyGroupsState extends Equatable {
  const MyGroupsState();

  @override
  List<Object> get props => [];
}

final class MyGroupsInitial extends MyGroupsState {}

final class MyGroupsLoading extends MyGroupsState {}

final class MyGroupsError extends MyGroupsState {
  final String myGroupsErrorMessage;
  const MyGroupsError(this.myGroupsErrorMessage);
}

class MyGroupsLoaded extends MyGroupsState {
  List<GroupModel> myGroups = [];
  MyGroupsLoaded(this.myGroups);
  // MyGroupsLoaded(List<GroupModel> newGroups) {
  //   myGroups.addAll(newGroups);
  // }
}
