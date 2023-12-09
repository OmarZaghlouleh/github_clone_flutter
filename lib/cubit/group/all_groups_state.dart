part of 'all_groups_cubit.dart';

sealed class AllGroupsState extends Equatable {
  const AllGroupsState();

  @override
  List<Object> get props => [];
}

final class AllGroupsInitial extends AllGroupsState {}

final class AllGroupsLoading extends AllGroupsState {}

final class AllGroupsError extends AllGroupsState {}

final class AllGroupsLoaded extends AllGroupsState {
  final List<GroupModel> groups;

  const AllGroupsLoaded(this.groups);
}
