import 'package:bloc/bloc.dart';

class SignupConfirmPasswordVisibilityCubit extends Cubit<bool> {
  SignupConfirmPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
