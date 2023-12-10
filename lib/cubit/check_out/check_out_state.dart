part of 'check_out_cubit.dart';

abstract class CheckOutState extends Equatable {
  const CheckOutState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CheckOutInitialState extends CheckOutState {
}

class CheckOutLoadingState extends CheckOutState {}

class CheckOutLoadedState extends CheckOutState {
  final CheckInAndCheckOutModel checkInAndCheckOutModel;

 const CheckOutLoadedState({required this.checkInAndCheckOutModel});

}

class CheckOutErrorState extends CheckOutState {
  final String messageError;

  const CheckOutErrorState({required this.messageError});

}
