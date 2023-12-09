part of 'reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}

final class ReportsLoading extends ReportsState {}

final class ReportsError extends ReportsState {}

final class ReportsLoaded extends ReportsState {
  final List<ReportModel> reports;

  const ReportsLoaded(this.reports);
}
