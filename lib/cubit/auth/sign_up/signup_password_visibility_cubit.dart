import 'package:bloc/bloc.dart';

class SignupPasswordVisibilityCubit extends Cubit<bool> {
  SignupPasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
