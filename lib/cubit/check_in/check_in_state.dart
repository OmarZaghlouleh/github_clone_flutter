part of 'check_in_cubit.dart';



@immutable
abstract class CheckInState {}

class CheckInInitialState extends CheckInState {}
class CheckInLoadingState extends CheckInState {}
class CheckInLoadedState extends CheckInState {
  final CheckInAndCheckOutModel checkInAndCheckOutModel;

  CheckInLoadedState({required this.checkInAndCheckOutModel});

}
class CheckInErrorState extends CheckInState {
  final String messageError;

  CheckInErrorState({required this.messageError});

}
class CheckInFile extends CheckInState{


}
class CheckOutFile extends CheckInState{


}
