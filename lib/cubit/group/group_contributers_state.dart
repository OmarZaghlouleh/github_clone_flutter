part of 'group_contributers_cubit.dart';

sealed class GroupContributersState extends Equatable {
  const GroupContributersState();

  @override
  List<Object> get props => [];
}

final class GroupContributersInitial extends GroupContributersState {}

final class GroupContributersLoading extends GroupContributersState {}

final class GroupContributersError extends GroupContributersState {}

final class GroupContributersLoaded extends GroupContributersState {
  final List<UserModel> contributers;

  const GroupContributersLoaded(this.contributers);
}
